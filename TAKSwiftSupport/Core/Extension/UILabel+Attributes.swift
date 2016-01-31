//
//  UILabelAttributes.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public extension UILabel {
    // http://iosfonts.com
    enum FontName: String {
        case AvenirLight = "Avenir-Light"
        case AvenirMedium = "Avenir-Medium"
        case Copperplate = "Copperplate"
        case CopperplateBold = "Copperplate-Bold"
        case CopperplateLight  = "Copperplate-Light"
        case HelveticaNeue = "HelveticaNeue"
        case HelveticaNeueBold = "HelveticaNeue-Bold"
        case HelveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
        case HiraKakuProW3 = "HiraKakuProN-W3"
        case HiraKakuProW6 = "HiraKakuProN-W6"
        case HiraMinProW3 = "HiraMinProN-W3"
        case HiraMinProW6 = "HiraMinProN-W6"
        case OptimaRegular = "Optima-Regular"
    }
    
    final class func font(name fontName: FontName, size: Float) -> UIFont {
        return UIFont(name: fontName.rawValue, size: CGFloat(size))!
    }
    
    /**
     Fill Color
     
     - parameter color: Fill Color
     */
    final class func attributeWithColor(color color: UIColor) -> [String: UIColor] {
        return [NSForegroundColorAttributeName: color]
    }
    
    /**
     OutLine
     
     - parameter color: Line Color
     - parameter width: Line Width
     */
    final class func attributeWithOutline(color color: UIColor, width: Int) -> [String: AnyObject] {
        return [
            NSStrokeColorAttributeName: color,
            NSStrokeWidthAttributeName: width
        ]
    }
    
    /**
     Font
     
     - parameter fontName: enum FontName
     - parameter size:     font size
     */
    final class func attributeWithFont(fontName: FontName, size: Float) -> [String: UIFont] {
        return [
            NSFontAttributeName: font(name: fontName, size: size)
        ]
    }
    
    /**
     Line Height
     
     - parameter lineHeight: Line Height
     */
    final class func attributeWithLineHeight(lineHeight: Float) -> [String: NSParagraphStyle] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = CGFloat(lineHeight);
        paragraphStyle.maximumLineHeight = CGFloat(lineHeight);
        
        return [NSParagraphStyleAttributeName: paragraphStyle]
    }
    
    /**
     Kerning
     
     - parameter em: Letter Spacing
     */
    final class func attributeWithKerning(em: Float) -> [String: Float] {
        return [
            NSKernAttributeName: em
        ]
    }
    
    /**
     Make AttributeString
     
     - parameter string:     String
     - parameter attributes: [Attribute]
     
     - returns: NSAttributedString
     */
    final class func attributedText(string string: String, attributes: [String: AnyObject]) -> NSAttributedString {
        let attrText = NSAttributedString(
            string: string,
            attributes: attributes
        )
        
        return attrText
    }
    
    // Join AttributeString
    final func joinAttributesStrings(strings strings: [NSAttributedString]) {
        let attrStrings = NSMutableAttributedString()
        for string in strings {
            attrStrings.appendAttributedString(string)
        }
        
        self.attributedText = attrStrings
    }
}
