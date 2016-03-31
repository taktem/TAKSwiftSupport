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
    final class func attributeWithColor(color color: UIColor) -> [String: AnyObject] {
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
    final class func attributeWithFont(fontName fontName: FontName, size: Float) -> [String: AnyObject] {
        return [
            NSFontAttributeName: font(name: fontName, size: size)
        ]
    }
	
	/**
	Font
	
	- parameter font: font
	*/
	final class func attributeWithFont(font font: UIFont) -> [String: AnyObject] {
		return [
			NSFontAttributeName: font
		]
	}
	
    /**
     Line Height
     Text Alignment
     
     - parameter lineHeight: Line Height
	- parameter alignment: Text Alignment
	*/
	final class func attributeWithParagraphStyle(lineHeight lineHeight: Float? = nil, alignment alignment: NSTextAlignment? = nil) -> [String: AnyObject] {
	
		let paragraphStyle = NSMutableParagraphStyle()
		
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = CGFloat(lineHeight);
            paragraphStyle.maximumLineHeight = CGFloat(lineHeight);
        }
        
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        return [NSParagraphStyleAttributeName: paragraphStyle]
    }
    
    /**
     BaselineOffset
     
     - parameter baseLineOffset: BaselineOffset
     */
    final class func attributeWithBaselineOffset(baseLineOffset baseLineOffset: Float) -> [String: AnyObject] {
        return [NSBaselineOffsetAttributeName: NSNumber(float: baseLineOffset)]
    }
    
    /**
     Kerning
     
     - parameter em: Letter Spacing
     */
    final class func attributeWithKerning(em em: Float) -> [String: AnyObject] {
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
    
	/**
	JoinAttributesStrings
	
	- parameter string:     String
	
	- returns: [NSAttributedString]
	*/
    final func joinAttributesStrings(strings strings: [NSAttributedString]) {
        let attrStrings = NSMutableAttributedString()
        for string in strings {
            attrStrings.appendAttributedString(string)
        }
        
        self.attributedText = attrStrings
    }
	
	/**
	OverRide Attributes Setting
	
	*/
	final func overrideAttributes(
		font font: UIFont? = nil,
		color: UIColor? = nil,
		borderColor: UIColor? = nil,
		borderWidth: Int = 0,
		kerning: Float? = nil,
		lineHeight: Float? = nil,
		alignment: NSTextAlignment? = nil
		) {
		
		guard let text = text else {
			return
		}
		
		var attributes = [String: AnyObject]()
		
		// font
		if let font = font {
			attributes += UILabel.attributeWithFont(font: font)
		}
		
		// color
		if let color = color {
			attributes += UILabel.attributeWithColor(color: color)
		}
		
		// border 
		if let borderColor = borderColor {
			attributes += UILabel.attributeWithOutline(color: borderColor, width: borderWidth)
		}
		
		// Kerning
		if let kerning = kerning {
			attributes += UILabel.attributeWithKerning(em: kerning)
		}
		
		// ParagraphStyle
		attributes += UILabel.attributeWithParagraphStyle(lineHeight: lineHeight, alignment: alignment)
		
		// set
		joinAttributesStrings(
			strings: [UILabel.attributedText(
				string: text,
				attributes: attributes)])
	}
	
	/**
	Update LabelText and return self
	
	*/
	final func setText(text text: String) -> UILabel {
		self.text = text
		return self
	}
}
