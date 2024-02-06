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
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .padding(.trailing, 20)
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
//        .previewLayout(.fixed(width: 400, height: 60)) // Not working with macro
    return cardView
}
