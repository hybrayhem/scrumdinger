//
//  DetailView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                Label("Start Meeting", systemImage: SFSymbols.timer.name)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                HStack {
                    Label("Length", systemImage: SFSymbols.clock.name)
                    Spacer()
                    Text("\(scrum.lengthInMinutes)")
                }
                .accessibilityElement(children: .combine) // combine label and text
                HStack {
                    Label("Theme", systemImage: SFSymbols.paintpalette.name)
                    Spacer()
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        DetailView(scrum: DailyScrum.sampleData[0])
    }
}
