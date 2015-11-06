//
//  ImageUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/06.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class ImageUtil: NSObject {
    
    public class func addGaussianBlur(image image: UIImage) -> UIImage? {
        let ciImage = CIImage(image: image)
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filteredImage = filter?.outputImage {
            let resultImage = UIImage(CIImage: filteredImage)
            return resultImage
        } else {
            return nil
        }
    }
}
