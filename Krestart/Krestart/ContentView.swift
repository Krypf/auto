import SwiftUI

struct ContentView: View {
    @StateObject private var restarter = AppRestarter()
    @State private var inputText: String = ""
    @State private var addText: String = ""
    @State private var showAddField: Bool = false
    @State private var showAppPicker: Bool = false
    
    @AppStorage("restartKey") var restartKey: String = "enter"
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Manual restart ────────────────────────────────────────────
            Group {
                Text("アプリ名で再起動")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 6)

                HStack(spacing: 8) {
                    TextField("例: Visual Studio Code", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit { triggerRestart(inputText) }

                    Button("Restart") { triggerRestart(inputText) }
                        .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty
                                  || restarter.isRestarting)
                        .keyboardShortcut(
                            restartKey == "command_enter" ? KeyEquivalent.return : KeyEquivalent.return,
                            modifiers: restartKey == "command_enter" ? .command : []
                        )
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Divider().padding(.vertical, 16)

            // ── Registered apps ───────────────────────────────────────────
            Group {
                Text("登録済みアプリ")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)

                if restarter.registeredApps.isEmpty {
                    Text("アプリを追加してください")
                        .font(.system(size: 13))
                        .foregroundStyle(.tertiary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 12)
                } else {
                    ForEach(restarter.registeredApps, id: \.self) { app in
                        AppRow(
                            name: app,
                            isRestarting: restarter.isRestarting,
                            onRestart: { triggerRestart(app) },
                            onRemove:  { restarter.remove(app) }
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 6)
                    }
                }

                // Add button / field
                if showAddField {
                    HStack(spacing: 8) {
                        TextField("アプリ名", text: $addText)
                            .textFieldStyle(.roundedBorder)
                            .onSubmit { commitAdd() }

                        Button("追加") { commitAdd() }
                        Button("キャンセル") {
                            addText = ""
                            showAddField = false
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 2)
                } else {
                    HStack(spacing: 8) {
                        Button(action: { showAppPicker = true }) {
                            Label("リストから追加", systemImage: "plus.circle")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 13))
                        }
                        .buttonStyle(.bordered)

                        Button(action: { showAddField = true }) {
                            Label("手入力", systemImage: "pencil")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 13))
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                }
            }

            Divider().padding(.top, 16)

            // ── Status bar ────────────────────────────────────────────────
            HStack(spacing: 6) {
                if restarter.isRestarting {
                    ProgressView().scaleEffect(0.6).frame(width: 14, height: 14)
                } else {
                    Circle()
                        .fill(restarter.status.contains("✓") ? .green : .secondary)
                        .frame(width: 7, height: 7)
                }
                Text(restarter.status)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.secondary)
        }
        .frame(width: 440)
        .sheet(isPresented: $showAppPicker) {
            AppPickerView { selected in
                restarter.add(selected)
            }
        }
    }

    // MARK: - Helpers

    private func triggerRestart(_ name: String) {
        let n = name.trimmingCharacters(in: .whitespaces)
        guard !n.isEmpty else { return }
        restarter.restart(n)
    }

    private func commitAdd() {
        restarter.add(addText)
        addText = ""
        showAddField = false
    }
}

// MARK: - App row

struct AppRow: View {
    let name: String
    let isRestarting: Bool
    let onRestart: () -> Void
    let onRemove:  () -> Void

    var body: some View {
        HStack(spacing: 10) {
            // Icon with the original AppIconView
            ZStack {
                AppIconView(appName: name)
                    .frame(width: 28, height: 28)
                
            }

            Text(name)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            Button("Restart", action: onRestart)
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(isRestarting)

            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 11))
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 0.5)
        )
    }

    private var iconColor: Color {
        let colors: [Color] = [.blue, .green, .orange, .purple, .red, .teal, .pink]
        let index = abs(name.hashValue) % colors.count
        return colors[index]
    }
}

struct AppIconView: View {
    let appName: String

    var icon: NSImage? {
        NSWorkspace.shared.runningApplications
            .first(where: {
                $0.localizedName?.lowercased() == appName.lowercased() ||
                $0.bundleURL?.deletingPathExtension().lastPathComponent.lowercased() == appName.lowercased()
            })?
            .icon
        ??
        NSWorkspace.shared.icon(forFile: "/Applications/\(appName).app")
            .self
    }

    var body: some View {
        if let icon = icon {
            Image(nsImage: icon)
                .resizable()
                .frame(width: 28, height: 28)
        } else {
            // フォールバック：頭文字
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(iconColor.opacity(0.15))
                Text(String(appName.prefix(1)))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(iconColor)
            }
        }
    }

    private var iconColor: Color {
        let colors: [Color] = [.blue, .green, .orange, .purple, .red, .teal, .pink]
        return colors[abs(appName.hashValue) % colors.count]
    }
}

#Preview {
    ContentView()
}
