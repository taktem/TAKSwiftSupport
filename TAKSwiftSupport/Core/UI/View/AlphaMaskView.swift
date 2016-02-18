//
//  AlphaMaskView.swift
//  AnaMile
//
//  Created by 西村 拓 on 2016/01/13.
//
//

import UIKit

/// アルファマスク設定用View
class AlphaMaskView: UIView {
    
    /// マスク境界位置調整
    @IBInspectable var threshold1: CGFloat = 0.0
    @IBInspectable var threshold2: CGFloat = 0.0
    
    /// 横方向にマスクする場合はtrue
    @IBInspectable var isHorizontal: Bool = false
    
    /// マスク方向を逆転する場合はtrue
    @IBInspectable var reverse: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setAlphaMask()
    }

    /**
     自分のView配下にマスク
     */
    private func setAlphaMask() {
        
        let mask = CAGradientLayer()
        mask.frame = bounds
        
        mask.colors = [
            UIColor.blackColor().CGColor,
            UIColor.blackColor().CGColor,
            UIColor.clearColor().CGColor
        ]
        
        mask.locations = [
            0.0,
            threshold1,
            threshold2
        ]
        
        let min = isHorizontal ? CGPointMake(0.0, 0.5) : CGPointMake(0.5, 0.0)
        let max = isHorizontal ? CGPointMake(1.0, 0.5) : CGPointMake(0.5, 1.0)
        
        if reverse {
            mask.startPoint = max;
            mask.endPoint = min;
        } else {
            mask.startPoint = min;
            mask.endPoint = max;
        }
        
        layer.mask = mask
    }

}
