//
//  Pie.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/27/25.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let startAngle = startAngle - .degrees(90)
            let endAngle = endAngle - .degrees(90)
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let start = CGPoint(
                x: center.x + radius * cos(startAngle.radians),
                y: center.y + radius * sin(startAngle.radians)
            )
            path.move(to: center)
            path.addLine(to: start)
            path.addArc(center: center,
                     radius: radius,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: false)
            path.addLine(to: center)
        }
    }
}
