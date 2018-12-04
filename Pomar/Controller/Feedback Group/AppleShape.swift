//
//  AppleShape.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

struct AppleShape {
    var path: UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 68.12, y: 123.67))
        shape.addCurve(to: CGPoint(x: 55.71, y: 38.19), controlPoint1: CGPoint(x: 17.02, y: 173.55), controlPoint2: CGPoint(x: -48.04, y: 16.08))
        shape.addCurve(to: CGPoint(x: 68.12, y: 123.67), controlPoint1: CGPoint(x: 140.5, y: -24.68), controlPoint2: CGPoint(x: 146.98, y: 157.59))
        shape.close()
        shape.move(to: CGPoint(x: 74.46, y: 0))
        shape.addCurve(to: CGPoint(x: 42.97, y: 30.47), controlPoint1: CGPoint(x: 49.5, y: 4.11), controlPoint2: CGPoint(x: 39.86, y: 13.67))
        shape.addCurve(to: CGPoint(x: 74.46, y: 0), controlPoint1: CGPoint(x: 56.86, y: 34.73), controlPoint2: CGPoint(x: 73.82, y: 24.95))
        shape.close()
        shape.apply(CGAffineTransform(scaleX: 0.7, y: 0.7))
        return shape
    }
}
