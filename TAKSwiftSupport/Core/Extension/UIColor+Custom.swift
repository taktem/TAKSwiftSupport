//
//  UIColor+Custom.swift
//  TAKSwiftSupport
//
//  Created by totem on 2014/06/11.
//  Copyright (c) 2016年 Taktem. All rights reserved.
//

import UIKit

public extension UIColor {
    
    // 16進数カラーコードからUIColorを生成する
    public convenience init(hexString: String) {
        var cString:String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            cString = "FFFFFF"
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /**
     alpha調整
     */
    func alpha(alpha: CGFloat) -> UIColor {
        return colorWithAlphaComponent(alpha)
    }
    
    // 16進数カラーコードからUIColorを生成する
    @available(*, deprecated=8.0, message="use UIColor(hexString:)")
    class func colorWithHexString(string string: String!, alpha:CGFloat) -> UIColor? {
        
        var cString:String = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
