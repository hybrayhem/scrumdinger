//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}


// Binding used to create two-way binding to a mutable state. A connection between the property that stores data, and the view that displays and changes the data.

// State used to create private mutable state owned by the current view. Used only with value types(struct, enum etc).

// ObservedObject, StateObject, and EnvironmentObject used with reference types(class).
