//
//  AnimationModifiers.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct FlashingAnimation: ViewModifier {
    @State private var isFlashing = false
    var shouldFlash: Bool

    func body(content: Content) -> some View {
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

struct Animations {
    static func flashing(shouldFlash: Bool) -> FlashingAnimation {
        FlashingAnimation(shouldFlash: shouldFlash)
    }
}

// Another method
//extension View {
//    func flashing(shouldFlash: Bool) -> some View {
//        self.modifier(FlashingAnimation(shouldFlash: shouldFlash))
//    }
//}

#Preview {
    VStack {
        Text("Hey").modifier(Animations.flashing(shouldFlash: true))
//        Text("Hey").flashing(shouldFlash: true)
    }
}
