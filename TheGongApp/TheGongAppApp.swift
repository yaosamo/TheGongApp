//
//  TheGongAppApp.swift
//  TheGongApp
//
//  Created by Yaroslav Samoylov on 6/21/25.
//

import SwiftUI
import SwiftData

@main
struct TheGongAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GongStats.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar) // ✅ Hide title bar
        .modelContainer(sharedModelContainer)
    }
}
