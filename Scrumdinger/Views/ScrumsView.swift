//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: Text(scrum.title)) { // Text is placeholder for detail page for now
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: SFSymbols.plus.name)
                }
                .accessibilityLabel("New scrum")
            }
        }
    }
}

#Preview {
    let scrums = DailyScrum.sampleData
    
    return ScrumsView(scrums: scrums)
}
