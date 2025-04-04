//
//  Pie.swift
//  memoryGame
//
//  Created by Lisa Jo on 3/27/25.
//

import SwiftUI

struct Pie: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addArc(center: .init(x: rect.midX, y: rect.midY),
                        radius: min(rect.width, rect.height) / 2,
                        startAngle: .degrees(0),
                        endAngle: .degrees(270),
                        clockwise: false)
        }
    }
                        
}
