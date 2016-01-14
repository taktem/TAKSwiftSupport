//
//  Trigonometric.swift
//  TAKSwiftSupport
//
//  Created by yamamotosaika on 2016/01/14.
//

import UIKit

public class Trigonometric: NSObject {
    
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
     サイズと中心座標を指定して半径と弧度から、円周上の座標を算出
     
     - parameter radius: 半径
     - parameter angle:  角度
     - parameter center: 基準となる中心点の座標
     - parameter size:   対象サイズ
     
     - returns: 座標
     */
    public class func pointOnCircumference(
        radius radius: Double,
        radian: Double,
        center: CGPoint,
        size: CGSize
        ) -> CGPoint {
            let x = CGFloat(radius * cos(radian)) + center.x - size.width / 2
            let y = CGFloat(radius * sin(radian)) + center.y - size.height / 2
            return CGPointMake(x, y)
    }
}

