//
//  CornerRoundedRectangle.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct CornerRoundedRectangle: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}
