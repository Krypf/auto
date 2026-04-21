import Foundation
import AppKit
import Combine

enum RestartError: LocalizedError {
    case appNotFound(String)
    case reopenFailed(String)

    var errorDescription: String? {
        switch self {
        case .appNotFound(let name):  return "'\(name)' が /Applications に見つかりません"
        case .reopenFailed(let name): return "'\(name)' の再起動に失敗しました"
        }
    }
}

class AppRestarter: ObservableObject {

    @Published var registeredApps: [String] = [] {
        didSet { UserDefaults.standard.set(registeredApps, forKey: "registeredApps") }
    }
    @Published var status: String = "待機中"
    @Published var isRestarting: Bool = false

    init() {
        registeredApps = UserDefaults.standard.stringArray(forKey: "registeredApps") ?? []
    }

    // MARK: - List management

    func add(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, !registeredApps.contains(trimmed) else { return }
        registeredApps.append(trimmed)
    }

    func remove(_ name: String) {
        registeredApps.removeAll { $0 == name }
    }

    // MARK: - Restart (sync entry point — spawns Task internally)

    func restart(_ name: String) {
        var name = name.trimmingCharacters(in: .whitespaces)
        if name.hasSuffix(".app") { name = String(name.dropLast(4)) }
        guard !name.isEmpty else { return }

        isRestarting = true
        status = "\(name) を終了中…"

        Task {
            let bundleID = await MainActor.run { self.terminateApp(name: name) }

            // Poll until quit (max 8 s)
            let deadline = Date.now.addingTimeInterval(8)
            while self.isRunning(name) && Date.now < deadline {
                try? await Task.sleep(nanoseconds: 500_000_000)
            }

            await MainActor.run { self.status = "\(name) を起動中…" }

            guard let bundleID = bundleID,
                  let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) else {
                await MainActor.run {
                    self.status = "エラー: \(name) が見つかりません"
                    self.isRestarting = false
                }
                return
            }

            let config = NSWorkspace.OpenConfiguration()
            do {
                try await NSWorkspace.shared.openApplication(at: appURL, configuration: config)
                await MainActor.run {
                    self.status = "\(name) を再起動しました ✓"
                    self.isRestarting = false
                }
            } catch {
                await MainActor.run {
                    self.status = "エラー: \(error.localizedDescription)"
                    self.isRestarting = false
                }
            }
        }
    }

    // MARK: - Helpers

    private func appURL(for name: String) throws -> URL {
        let paths = [
            "/Applications/\(name).app",
            "/System/Applications/\(name).app",
            "/System/Applications/Utilities/\(name).app",
            "\(NSHomeDirectory())/Applications/\(name).app"
        ]
        
        for path in paths where FileManager.default.fileExists(atPath: path) {
            return URL(fileURLWithPath: path)
        }
        throw RestartError.appNotFound(name)
    }

    private func isRunning(_ name: String) -> Bool {
        NSWorkspace.shared.runningApplications.contains {
            $0.localizedName?.lowercased() == name.lowercased() ||
            $0.bundleURL?.deletingPathExtension().lastPathComponent.lowercased() == name.lowercased()
        }
    }
    
    private func terminateApp(name: String) -> String? {
        let running = NSWorkspace.shared.runningApplications
            .filter {
                $0.localizedName?.lowercased() == name.lowercased() ||
                $0.bundleURL?.deletingPathExtension().lastPathComponent.lowercased() == name.lowercased()
            }

        guard !running.isEmpty else { return nil }

        let bundleID = running.first?.bundleIdentifier

        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", "osascript -e 'tell application \"\(name)\" to quit'"]
        try? task.run()

        return bundleID
    }
}
