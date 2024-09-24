//
//  EpistolaireApp.swift
//  Epistolaire
//
//  Created by Olivier Conan on 23/09/2024.
//

import SwiftUI
import Messaging

@main
struct EpistolaireApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
