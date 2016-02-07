//
//  Circumference.swift
//  TAKSwiftSupport
//
//  Created by yamamotosaika on 2016/01/14.
//

import UIKit

public extension Double {
    /**
     度数法表記を弧度法表記に変換
     
     - returns: ラジアン
     */
    func toRadian() -> Double {
        return self * M_PI / 180.0
    }
    
    /**
     弧度法表記を度数法表記に変換
     
     - returns: 角度
     */
    func toAngle() -> Double {
        return self * 180.0 / M_PI
    }
}

public class Circumference: NSObject {
    
    /**
     度数法表記を弧度法表記に変換
     
     - parameter angle: 角度
     
     - returns: ラジアン
     */
    public class func toRadian(angle: Double) -> Double {
        return angle * M_PI / 180.0
    }
    
    /**
     半径と弧度から、円周上の座標を算出
     
     - parameter radius: 半径
     - parameter angle:  角度
     
     - returns: 座標
     */
    public class func pointOnCircumference(
        radius radius: Double,
        radian: Double) -> CGPoint {
            
        let x = radius * cos(radian)
        let y = radius * sin(radian)
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    /**
     中心座標を指定して半径と弧度から、円周上の座標を算出
     
     - parameter radius: 半径
     - parameter angle:  角度
     - parameter center: 基準となる中心点の座標
     
     - returns: 座標
     */
    public class func pointOnCircumference(
        radius radius: Double,
        radian: Double,
        center: CGPoint
        ) -> CGPoint {
            let x = pointOnCircumference(radius: radius, radian: radian).x + center.x
            let y = pointOnCircumference(radius: radius, radian: radian).y + center.y
            return CGPointMake(x, y)
    }
}

