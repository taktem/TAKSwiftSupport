//
//  CGPoint+Vector.swift
//  Pods
//
//  Created by 西村 拓 on 2016/02/07.
//
//

import UIKit

/// Vector2D
public extension CGPoint {
    var length: CGFloat {
        get {
            return sqrt(x * x + y * y)
        }
    }
    
    var unit: CGPoint {
        get {
            return self * (1.0 / length)
        }
    }
    
    var angle: CGFloat {
        get {
            if min(fabs(x), fabs(y)) <= 0 {
                return CGFloat(0.0)
            }
            
            return (x + y) / (x * y)
        }
    }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (inout left: CGPoint, right: CGPoint) {
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= (inout left: CGPoint, right: CGPoint) {
    left = left - right
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func *= (inout left: CGPoint, right: CGPoint) {
    left = left * right
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

public func *= (inout left: CGPoint, right: CGFloat) {
    left = left * right
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func /= (inout left: CGPoint, right: CGPoint) {
    left = left / right
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

public func /= (inout left: CGPoint, right: CGFloat) {
    left = left / right
}

public func mix(point1 point1: CGPoint, point2: CGPoint, percentage: CGFloat) -> CGPoint {
    return CGPoint(x: point1.x * (1.0 - percentage) + point2.x * percentage, y: point1.y * (1.0 - percentage) + point2.y * percentage)
}
