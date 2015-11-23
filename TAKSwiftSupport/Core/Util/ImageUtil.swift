//
//  ImageUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/06.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class ImageUtil: NSObject {
    
    /**
     ガウスエフェクトをかける
     
     - parameter image:       元の画像
     - parameter inputRadius: エフェクトの強さ
     */
    public class func addGaussianBlur(
        image image: UIImage?,
        inputRadius: Double
        ) -> UIImage? {
        guard let image = image else {
            return nil
        }
            
        let ciImage = CIImage(image: image)
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(inputRadius, forKey: "inputRadius")
        
        if let filteredImage = filter?.outputImage {
            let resultImage = UIImage(CIImage: filteredImage)
            return resultImage
        } else {
            return nil
        }
    }
    
    /**
     UIViewから画像を生成する
     
     - parameter view:      元のView
     - parameter translate: 基準位置調整
     - parameter size:      生成される画像のサイズ
     */
    public class func imageFromView(
        view view: UIView?,
        translate: CGPoint,
        size: CGSize
        ) -> UIImage? {
            guard let view = view else {
                return nil
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            
            CGContextTranslateCTM(context, translate.x, translate.y)
            
            view.layer.renderInContext(context!)
            
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return resultImage
    }
    
    /**
     画像を単色で塗りつぶす
     
     - parameter image:     元の画像
     - parameter color:     塗りつぶし色
     - parameter blendMode: ブレンドモード
     */
    class func fillImage(image image:UIImage, color:UIColor, blendMode:CGBlendMode) -> UIImage {
        let size = image.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        
        let bounds = CGRectMake(0.0, 0.0, size.width, size.height)
        UIRectFill(bounds)
        
        image.drawInRect(bounds, blendMode: blendMode, alpha: 1.0)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
