//
//  RecipesApp.swift
//  Recipes
//
//  Created by Kevin Tierney on 2/25/22.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        
        WindowGroup {
            ReciepTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
