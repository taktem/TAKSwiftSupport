//
//  UIView+Activate.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/19.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Windowに表示
     */
    public class func showOnWindow() {
        guard let view = self.create() else {
            return
        }
        
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
        window.rootViewController?.view .addSubview(view)
    }
    
    /**
     クラス名と同名のxibファイルからUIViewを生成
     
     - returns: UIView
     */
    public class func create() -> UIView? {
        let className = NSStringFromClass(self).componentsSeparatedByString(".").last! as String
        let nib = UINib(nibName: className, bundle: NSBundle.mainBundle())
        let objects = nib.instantiateWithOwner(nil, options: nil)
        
        if objects.count > 0 {
            return objects.first as? UIView
        }
        
        return nil
    }
}