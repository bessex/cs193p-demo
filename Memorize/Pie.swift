//
//  Pie.swift
//  Memorize
//
//  Created by Ben Essex and Paul Haggerty on 11 Jun 22.
//

import SwiftUI

struct Pie: Shape, Animatable {
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.degrees, endAngle.degrees)
        }
        
        set {
            startAngle = Angle(degrees: newValue.first)
            endAngle = Angle(degrees: newValue.second)
        }
    }
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        return p
    }
    
    
}
