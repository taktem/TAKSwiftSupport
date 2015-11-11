//
//  UILabelExtension.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func attributeStringWithColor(string string: String, color: UIColor) -> NSAttributedString {
        let attrText = NSAttributedString(
            string: string,
            attributes: [NSForegroundColorAttributeName: color]
        )
        
        return attrText
    }
    
    func joinAttributesStrings(strings strings: [NSAttributedString]) {
        let attrStrings = NSMutableAttributedString()
        for string in strings {
            attrStrings.appendAttributedString(string)
        }
        
        self.attributedText = attrStrings
    }
    
    func setLetterSpacing(space space: Int) {
        if let text = self.text {
            let attributedText = NSMutableAttributedString(string: text)
            
            attributedText.addAttribute(
                NSKernAttributeName,
                value: space, range:
                NSMakeRange(0, attributedText.length)
            )
            
            self.attributedText = attributedText
        }
    }
}
