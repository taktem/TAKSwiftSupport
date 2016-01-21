//
//  UIButtonExtension.swift
//  Pods
//
//  Created by yamamotosaika on 2016/01/21.
//
//

import UIKit

public extension UIButton {

    /**
     fill the button background with the specific color for the specified button state.
     
     - parameter color: color
     - parameter state: state
     */
    func setFillColor(color color: UIColor, forState state: UIControlState) {
        setBackgroundImage(UIImage.imageWithFillColor(color: color), forState: state)
    }
    
    /**
     fill the button background with the specific color for the specified button state.
     
     - parameter hex:   hex
     - parameter state: state
     */
    func setFillColor(hex hex: String, forState state: UIControlState) {
        guard let color = UIColor.colorWithHexString(string: hex, alpha: alpha) else {
            setBackgroundImage(UIImage.imageWithFillColor(color: UIColor.clearColor()), forState: state)
            return
        }
        setBackgroundImage(UIImage.imageWithFillColor(color: color), forState: state)
    }

    /**
     fill the button background with the specific color for the specified button state.
     
     - parameter hex:   hex
     - parameter alpha: alpha
     - parameter state: state
     */
    func setFillColor(hex hex: String, alpha: CGFloat, forState state: UIControlState) {
        guard let color = UIColor.colorWithHexString(string: hex, alpha: alpha) else {
            setBackgroundImage(UIImage.imageWithFillColor(color: UIColor.clearColor()), forState: state)
            return
        }
        setBackgroundImage(UIImage.imageWithFillColor(color: color), forState: state)
    }
}
