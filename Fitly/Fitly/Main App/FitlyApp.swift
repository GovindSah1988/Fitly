//
//  FitlyApp.swift
//  Fitly
//
//  Created by Govind Sah on 12/07/25.
//

import SwiftUI
import SwiftData
import FoundationModels

@main
struct FitlyApp: App {
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

    @State private var languageModelManager = LanguageModelManager()

    var body: some Scene {
        WindowGroup {
//            MainView(languageModelManager: languageModelManager)
//                .environment(languageModelManager)
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
