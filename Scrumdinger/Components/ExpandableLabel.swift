//
//  ExpandableLabel.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ExpandableLabel: View {
    @State private var isExpanded = false
    let symbol: SFSymbols
    let text: String
    let description: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }) {
            HStack(alignment: .top) {
                Image(symbol: symbol)
                VStack(alignment: .leading) {
                    Text(text)
                        .lineLimit(isExpanded ? nil : 1)
                        .multilineTextAlignment(.leading)
                    if isExpanded {
                        Text(description)
                            .font(.footnote)
//                            .opacity(0.75)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Image(symbol: .chevron_right)
                    .scaleEffect(0.75)
                    .foregroundColor(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                
            }
        }
        .foregroundColor(.primary)
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    ExpandableLabel(
        symbol: .calendar,
        text: "This is a very long text that will be truncated unless the label is expanded.",
        description: "This is a short description."
    )
    .padding()
}
