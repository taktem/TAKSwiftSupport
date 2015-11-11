//
//  ImageUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/06.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class ImageUtil: NSObject {
    
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
}
