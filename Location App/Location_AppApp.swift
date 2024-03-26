//
//  Location_AppApp.swift
//  Location App
//
//  Created by yatziri on 28/11/23.
//

import SwiftUI
import SwiftData

@main
struct Location_AppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Alarms.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
//    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
//        .modelContainer(ItemsContainer.create(shouldCreateDefaults: &isFirstTimeLaunch))
        
    }
}
