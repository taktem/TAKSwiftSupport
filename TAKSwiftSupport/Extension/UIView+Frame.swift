//
//  UIViewExtension.swift
//  TAKSwiftSupport
//
//  Created by totem on 2014/06/23.
//  Copyright (c) 2014年 Taktem. All rights reserved.
//

import UIKit

public extension UIView {
    func width() -> CGFloat {
        return CGRectGetWidth(self.frame)
    }
    
    func setWidth(width:CGFloat) {
        self.frame = CGRectMake(
            self.frame.origin.x,
            self.frame.origin.y,
            width,
            self.frame.size.height
        )
    }
    
    func height() -> CGFloat {
        return CGRectGetWidth(self.frame)
    }
    
    func setHeight(height:CGFloat) {
        self.frame = CGRectMake(
            self.frame.origin.x,
            self.frame.origin.y,
            self.frame.size.width,
            height
        )
    }
}
