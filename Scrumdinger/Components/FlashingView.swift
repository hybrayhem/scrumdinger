//
//  FlashingView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct FlashingView<Content: View>: View {
    @State private var isFlashing = false
    var shouldFlash: Bool
    let content: Content

    init(shouldFlash: Bool, @ViewBuilder content: () -> Content) {
        self.shouldFlash = shouldFlash
        self.content = content()
    }

    var body: some View {
        content
            .opacity(isFlashing ? 0.25 : 1.0)
            .animation(isFlashing ? .linear(duration: 1.6).repeatForever(autoreverses: true) : .none, value: isFlashing)
            .onAppear {
                isFlashing = shouldFlash
            }
            .onChange(of: shouldFlash) { newValue in
                isFlashing = newValue
            }
    }
}

#Preview {
    FlashingView(shouldFlash: true) {
        Text("Hey")
    }
}
