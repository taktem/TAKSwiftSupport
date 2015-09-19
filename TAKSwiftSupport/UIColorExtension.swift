//
//  UIColorExtension.swift
//  TaktemSwiftSupport
//
//  Created by totem on 2014/06/11.
//  Copyright (c) 2014年 Taktem. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 16進数カラーコードからUIColorを生成する
    class func colorWithHexString(string string: String!, alpha:CGFloat) -> UIColor? {
        
        var cString:String = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (countElements(cString) != 6) {
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
