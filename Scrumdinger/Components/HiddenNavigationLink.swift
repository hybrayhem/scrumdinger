//
//  HiddenNavigationLink.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct HiddenNavigationLink<Destination: View, Content: View>: View {
    let destination: Destination
    let content: Content

    init(destination: Destination, @ViewBuilder content: () -> Content) {
        self.destination = destination
        self.content = content()
    }

    var body: some View {
        ZStack {
            NavigationLink(destination: destination) { EmptyView() }
                .opacity(0)
                .frame(maxWidth: .zero, maxHeight: .zero)
            
            content
        }
    }
}

#Preview {
    HiddenNavigationLink(destination: Text("hello")) {
        Text("Hello, world!")
    }
}
