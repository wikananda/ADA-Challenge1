//
//  Challenge1App.swift
//  Challenge1
//
//  Created by Komang Wikananda on 11/04/25.
//

import SwiftUI
import SwiftData

@main
struct Challenge1App: App {
    @Environment(\.modelContext) private var context
    
    var body: some Scene {
        WindowGroup {
            SpicerView()
                .modelContainer(for: [FoodData.self, UserData.self])
                .environment(\.colorScheme, .light)
        }
    }
}
