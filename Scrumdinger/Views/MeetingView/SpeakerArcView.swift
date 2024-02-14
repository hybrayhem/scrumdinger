//
//  SpeakerArcView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct SpeakerArcView: View {
    let speakerIndex: Int
    let totalSpeakers: Int
    let speakerProgress: Double
    let theme: Theme
    
    var body: some View {
        // Elapsed Arc
        if speakerProgress != 0.0 {
            SpeakerArc(
                speakerIndex: speakerIndex,
                totalSpeakers: totalSpeakers,
                endProgress: speakerProgress
            )
            .rotation(Angle(degrees: -90))
            .stroke(theme.mainColor, lineWidth: 11)
        }
        
        // Remaining Arc
        if speakerProgress != 1.0 {
            SpeakerArc(
                speakerIndex: speakerIndex,
                totalSpeakers: totalSpeakers,
                startProgress: speakerProgress,
                endProgress: 1.0 - speakerProgress
            )
            .rotation(Angle(degrees: -90))
            .stroke(theme.mainColor.opacity(0.5), lineWidth: 11)
        }
    }
}

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    var startProgress: Double = 0.0
    let endProgress: Double
    
    private var degreePerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    private var spacing: Double {
        return (startProgress == 0.0 && endProgress != 1.0) ? 0.0 : 1.0 // if between half-elapsed and half-remaining arc
    }
    
    private var startAngle: Angle {
        let progressOffset = degreePerSpeaker * startProgress
        return Angle(degrees: degreePerSpeaker * Double(speakerIndex) + progressOffset + 1.0)
    }
    
    private var endAngle: Angle {
        let progressOffset = degreePerSpeaker * endProgress
        return Angle(degrees: startAngle.degrees + progressOffset - spacing)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 22.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    let arc1 = SpeakerArcView(speakerIndex: 2, totalSpeakers: 5, speakerProgress: 1.0, theme: .navy)
    let arc2 = SpeakerArcView(speakerIndex: 3, totalSpeakers: 5, speakerProgress: 0.6, theme: .indigo)
    let arc3 = SpeakerArcView(speakerIndex: 4, totalSpeakers: 5, speakerProgress: 0.0, theme: .oxblood)
    
    return VStack {
        VStack {
            arc1
            arc2
            arc3
        }
        Circle()
            .opacity(0.1)
            .overlay{ arc1 }
            .overlay{ arc2 }
            .overlay{ arc3 }
    }
}
