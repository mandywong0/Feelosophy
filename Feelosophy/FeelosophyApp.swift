//
//  FeelosophyApp.swift
//  Feelosophy
//
//  Created by Justin Lee on 12/3/23.
//

import SwiftUI
import SwiftData

@main
struct FeelosophyApp: App {
    @State private var showing = false
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            TabView {
                MainMenuView()
                    .tabItem { Label("Home", systemImage: "house") }
                QuestionView()
                    .tabItem {
                        Label("Mood", systemImage: "lightbulb.min")
                    }
                ContentView()
                    .tabItem { Label("Log of Moods", systemImage: "rectangle.stack") }
            }
            .modelContainer(sharedModelContainer)
        }
    }
}
