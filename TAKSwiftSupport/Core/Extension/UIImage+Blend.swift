//
//  UIImage+Blend.swift
//  Pods
//
//  Created by 西村 拓 on 2016/02/03.
//
//

import UIKit

public extension UIImage {
    /**
     画像を単色で塗りつぶす
    
     - parameter color:     塗りつぶし色
     - parameter blendMode: ブレンドモード
     */
    final func fillImage(color:UIColor, blendMode:CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        
        let bounds = CGRectMake(0.0, 0.0, size.width, size.height)
        UIRectFill(bounds)
        
        drawInRect(bounds, blendMode: blendMode, alpha: 1.0)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
