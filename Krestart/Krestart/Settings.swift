//
//  Settings.swift
//  Krestart
//
//  Created by krypf on 2026/04/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("restartKey") var restartKey: String = "enter"

    var body: some View {
        Form {
            Picker("Restart ショートカット", selection: $restartKey) {
                Text("Enter").tag("enter")
                Text("⌘ + Enter").tag("command_enter")
            }
            .pickerStyle(.radioGroup)
        }
        .padding()
        .frame(width: 300)
    }
}
