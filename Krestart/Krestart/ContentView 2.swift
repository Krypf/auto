//
//  ContentView.swift
//  Krestart
//

import SwiftUI

struct ContentView: View {
    @StateObject private var restarter = Krestart()
    @State private var inputText: String = ""
    @State private var showingAddSheet: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            VStack(alignment: .leading, spacing: 8) {
                Text("section.restart_by_name", comment: "Section header")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)

                HStack(spacing: 8) {
                    TextField("field.app_name_placeholder", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit { triggerRestart(inputText) }

                    Button("button.restart") {
                        triggerRestart(inputText)
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty || restarter.isRestarting)
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
            .padding(20)

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("section.saved_apps", comment: "Section header")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)

                if restarter.savedApps.isEmpty {
                    Text("label.no_apps")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                } else {
                    List {
                        ForEach(restarter.savedApps, id: \.self) { appName in
                            HStack(spacing: 10) {
                                AppIconView(name: appName)
                                Text(appName)
                                    .font(.system(size: 14))
                                Spacer()
                                Button("button.restart") {
                                    triggerRestart(appName)
                                }
                                .buttonStyle(.bordered)
                                .controlSize(.small)
                                .disabled(restarter.isRestarting)
                            }
                            .padding(.vertical, 2)
                        }
                        .onDelete(perform: restarter.removeApp)
                    }
                    .listStyle(.plain)
                    .frame(minHeight: 100)
                }

                Button(action: { showingAddSheet = true }) {
                    Label("button.add_app", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()

            HStack(spacing: 6) {
                if restarter.isRestarting {
                    ProgressView()
                        .scaleEffect(0.6)
                        .frame(width: 14, height: 14)
                }
                Text(restarter.status)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.5))
        }
        .frame(width: 420)
        .sheet(isPresented: $showingAddSheet) {
            AddAppSheet(isPresented: $showingAddSheet) { name in
                restarter.addApp(name)
            }
        }
    }

    private func triggerRestart(_ name: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        restarter.restart(appName: name)
    }
}

struct AppIconView: View {
    let name: String
    private var initial: String { String(name.prefix(1).uppercased()) }
    private var color: Color {
        let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .teal]
        return colors[abs(name.hashValue) % colors.count]
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color.opacity(0.15))
                .frame(width: 28, height: 28)
            Text(initial)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(color)
        }
    }
}

struct AddAppSheet: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    let onAdd: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("sheet.add_app.title")
                .font(.system(size: 16, weight: .medium))
            TextField("field.app_name_hint", text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit { submit() }
            Text("sheet.add_app.hint")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
            HStack {
                Spacer()
                Button("button.cancel") { isPresented = false }
                    .keyboardShortcut(.escape)
                Button("button.add") { submit() }
                    .keyboardShortcut(.return)
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(width: 340)
    }

    private func submit() {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        onAdd(trimmed)
        isPresented = false
    }
}

#Preview("English") {
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Japanese") {
    ContentView()
        .environment(\.locale, Locale(identifier: "ja"))
}
