//
//  NSURL+Open.swift
//  TAKSwiftSupport
//
//  Created by totem on 2016/01/26.
//  Copyright (c) 2014年 Taktem. All rights reserved.
//

import UIKit

/// URL Open
public extension NSURL {
    final func open() {
        if UIApplication.sharedApplication().canOpenURL(self) {
            UIApplication.sharedApplication().openURL(self)
        }
    }
    
}
