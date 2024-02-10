//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State var isPresentingNewScrumView = false
    
    // Monitor app activity state
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        AdaptiveNavigationStack {
            List {
                ForEach($scrums) { $scrum in
                    NavigationLink(destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                    }
                    .listRowBackground(scrum.theme.mainColor)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(symbol: .plus)
                }
                .accessibilityLabel("New scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        scrums.remove(atOffsets: offsets)
    }
}

#Preview {
    let scrums = DailyScrum.sampleData
    
    return ScrumsView(scrums: .constant(scrums), saveAction: {})
}
