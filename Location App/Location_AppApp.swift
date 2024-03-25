//
//  Location_AppApp.swift
//  Location App
//
//  Created by yatziri on 28/11/23.
//

import SwiftUI

@main
struct Location_AppApp: App {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ItemsContainer.create(shouldCreateDefaults: &isFirstTimeLaunch))
    }
}
