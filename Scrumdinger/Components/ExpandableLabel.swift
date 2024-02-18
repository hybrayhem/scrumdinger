//
//  ExpandableLabel.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ExpandableLabel<Content: View>: View {
    @State private var isExpanded = false
    let symbol: SFSymbols
    let text: String
    let description: String
    let content: Content
    
    init(symbol: SFSymbols, text: String, description: String, @ViewBuilder content: () -> Content) {
        self.symbol = symbol
        self.text = text
        self.description = description
        self.content = content()
    }
    
    var body: some View {
            // Symbol + ...
            HStack(alignment: .top) {
                Image(symbol: symbol)
                    .padding(.trailing)
                // ... + Content
                VStack(alignment: .leading) {
                    // ... + Chevron Symbol
                    HStack {
                        // Text + Description
                        VStack(alignment: .leading) {
                            Text(text)
                                .lineLimit(isExpanded ? nil : 1)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if isExpanded {
                                Text(description)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Image(symbol: .chevron_right)
                            .scaleEffect(0.75)
                            .foregroundColor(.secondary)
                            .rotationEffect(.degrees(isExpanded ? 90 : 0))
                    }
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                    
                    if isExpanded {
                        content
                    }
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
    ) {
        Text("hey")
    }
    .padding()
}
