//
//  AppPickerView.swift
//  Krestart
//
//  Created by krypf on 2026/04/21.
//

import SwiftUI
import AppKit

struct AppPickerView: View {
    @Environment(\.dismiss) var dismiss
    var onSelect: (String) -> Void

    @State private var runningApps: [NSRunningApplication] = []
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("アプリを選択して追加")
                .font(.system(size: 13, weight: .medium))
                .padding(16)

            Divider()

            List(Array(runningApps.enumerated()), id: \.offset) { index, app in
                Button(action: { select(app) }) {
                    HStack(spacing: 10) {
                        if let icon = app.icon {
                            Image(nsImage: icon)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text(app.localizedName ?? "Unknown")
                            .font(.system(size: 13))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
                    .background(index == selectedIndex
                        ? Color.accentColor.opacity(0.2)
                        : Color.clear)
                    .cornerRadius(6)
                }
                .buttonStyle(.plain)
            }
            .frame(minHeight: 300)

            Divider()

            Button("キャンセル") { dismiss() }
                .padding(12)
        }
        .frame(width: 280)
        .onAppear { loadApps() }
        .onKeyPress(.upArrow)   { move(-1); return .handled }
        .onKeyPress(.downArrow) { move(+1); return .handled }
        .onKeyPress(.return)    { confirmSelection(); return .handled }
        .onKeyPress(.escape)    { dismiss(); return .handled }
    }

    private func loadApps() {
        runningApps = NSWorkspace.shared.runningApplications
            .filter { $0.activationPolicy == .regular }
            .sorted { ($0.localizedName ?? "") < ($1.localizedName ?? "") }
    }

    private func move(_ delta: Int) {
        let next = selectedIndex + delta
        if next >= 0 && next < runningApps.count {
            selectedIndex = next
        }
    }

    private func confirmSelection() {
        guard selectedIndex < runningApps.count else { return }
        select(runningApps[selectedIndex])
    }

    private func select(_ app: NSRunningApplication) {
        if let name = app.bundleURL?.deletingPathExtension().lastPathComponent {
            onSelect(name)
        }
        dismiss()
    }
}
