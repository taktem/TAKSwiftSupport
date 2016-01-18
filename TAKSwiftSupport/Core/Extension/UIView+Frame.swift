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
        return CGRectGetWidth(frame)
    }
    
    func setWidth(width:CGFloat) {
        frame = CGRectMake(
            frame.origin.x,
            frame.origin.y,
            width,
            frame.size.height
        )
    }
    
    func height() -> CGFloat {
        return CGRectGetHeight(frame)
    }
    
    func setHeight(height:CGFloat) {
        frame = CGRectMake(
            frame.origin.x,
            frame.origin.y,
            frame.size.width,
            height
        )
    }
}
