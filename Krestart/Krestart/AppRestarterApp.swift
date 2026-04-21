import SwiftUI

@main
struct AppRestarterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 440, height: 500)
        
        Settings {
                    SettingsView()
                }
    }
}
