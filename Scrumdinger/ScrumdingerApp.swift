//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(
                scrums: $store.scrums,
                saveAction: { storeSave() } // Save on exit
            )
            .task { await storeLoad() } // Load on start
        }
    }
    
    private func storeLoad() async {
        do {
            try await store.load()
        } catch {
            fatalError(error.localizedDescription) // TODO: Show alert
        }
    }
    
    private func storeSave() {
        Task {
            do {
                try await store.save(changedScrums: store.scrums)
            } catch {
                fatalError(error.localizedDescription) // TODO: Show alert
            }
        }
    }
}


// Binding used to create two-way binding to a mutable state. A connection between the property that stores data, and the view that displays and changes the data.

// State used to create private mutable state owned by the current view. Used only with value types(struct, enum etc).

// ObservedObject, StateObject, and EnvironmentObject used with reference types(class).
