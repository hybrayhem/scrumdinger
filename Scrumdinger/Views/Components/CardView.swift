//
//  CardView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader) // scrum.title followed by "heading."
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: SFSymbols.person_3.name)
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: SFSymbols.clock.name)
                    .accessibilityLabel("\(scrum.lengthInMinutes) minutes meeting length")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
    }
}

@available(iOS 17, *)
#Preview(
    "Design Scrum",
    traits: .fixedLayout(width: 400, height: 60))
{
    let scrum = DailyScrum.sampleData.first!
    
    let cardView = CardView(scrum: scrum)
        .background(scrum.theme.mainColor)
    return cardView
}
