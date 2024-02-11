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
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(
                scrums: $store.scrums,
                saveAction: { storeSave() } // Save on exit
            )
            .task { await storeLoad() } // Load on start
            .sheet(
                item: $errorWrapper, // Triggered by errorWrapper state changes
                onDismiss: {
                    store.scrums = DailyScrum.sampleData
                },
                content: { wrapper in
                    ErrorView(
                        errorWrapper: wrapper
                    )
                }
            )
        }
    }
    
    private func storeLoad() async {
        do {
            try await store.load()
        } catch {
            errorWrapper = ErrorWrapper(
                error: error,
                guidance: "Scrumdinger will load sample data and continue.")
        }
    }
    
    private func storeSave() {
        Task {
            do {
                try await store.save(changedScrums: store.scrums)
            } catch {
                errorWrapper = ErrorWrapper(
                    error: error,
                    guidance: "Try again later.")
            }
        }
    }
}


// Binding used to create two-way binding to a mutable state. A connection between the property that stores data, and the view that displays and changes the data.

// State used to create private mutable state owned by the current view. Used only with value types(struct, enum etc).

// ObservedObject, StateObject, and EnvironmentObject used with reference types(class).
