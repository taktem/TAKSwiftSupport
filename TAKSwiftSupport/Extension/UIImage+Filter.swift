//
//  UIViewExtension.swift
//  TAKSwiftSupport
//
//  Created by totem on 2014/06/23.
//  Copyright (c) 2014年 Taktem. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     訂正レベル
     
     - LevelL: 誤り訂正レベル7%
     - LevelM: 誤り訂正レベル15%
     - LevelQ: 誤り訂正レベル25%
     - LevelH: 誤り訂正レベル30%
     */
    enum InputCorrectionLebel: String {
        case LevelL = "L"
        case LevelM = "M"
        case LevelQ = "Q"
        case LevelH = "H"
    }
    
    /**
     文字列と訂正レベルを指定してQRコードを生成する
     */
    class func createQRCode(
        value value: String,
        size: CGSize,
        inputCorrectionLebel: InputCorrectionLebel
        ) -> UIImage? {
            
            // フィルター生成
            guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
            }
            filter.setDefaults()
        
            // 入力データ生成
            let qrData = value.dataUsingEncoding(NSUTF8StringEncoding)
            
            filter.setValue(qrData, forKey: "inputMessage")
            filter.setValue(inputCorrectionLebel.rawValue, forKey: "inputCorrectionLevel")
            
            // 画像として出力
            let ciContext = CIContext(options: nil)

            guard let outputImage = filter.outputImage else {
                return nil
            }
            let cgImage = ciContext.createCGImage(outputImage, fromRect: outputImage.extent)
            var image = UIImage(CGImage: cgImage, scale: UIScreen.mainScreen().scale, orientation: UIImageOrientation.Up)
            
            // 出力された画像が小さいのでリサイズをかける
            UIGraphicsBeginImageContext(size)
            let cgContext = UIGraphicsGetCurrentContext()
            CGContextSetInterpolationQuality(cgContext, .None)
            image.drawInRect(CGRectMake(0, 0, size.width, size.height))
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
    }
}

