//
//  UIColorSpacing.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

extension UILabel {
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
