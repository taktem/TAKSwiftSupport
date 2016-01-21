//
//  UIImageExtension.swift
//  Pods
//
//  Created by yamamotosaika on 2016/01/21.
//
//

import UIKit

public extension UIImage {
   
    /**
     create an image with the specified color
     
     - parameter color: color
     
     - returns: image
     */
    class func imageWithFillColor(color color: UIColor) -> Self {
        return instatiateWithFillColor(color: color)
    }

    private class func instatiateWithFillColor<T>(color color: UIColor) -> T {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let contextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(contextRef, color.CGColor)
        CGContextFillRect(contextRef, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image as! T
    }
}
