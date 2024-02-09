//
//  AdaptiveNavigationStack.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct AdaptiveNavigationStack<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content()
            }
        } else {
            NavigationView {
                content()
            }
        }
    }
}
