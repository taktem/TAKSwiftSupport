 //
//  BaseView.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/09/19.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

 public class BaseView: UIView {
    
    /**
    クラス名と同名のxibファイルからUIViewを生成
    
    - returns: UIView
    */
    public class func view() -> BaseView {
        let className = NSStringFromClass(self).componentsSeparatedByString(".").last! as String
        return UINib(nibName: className, bundle: NSBundle.mainBundle()).instantiateWithOwner(nil, options: nil)[0] as! BaseView
    }
    
    public class func show() {
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
        window.rootViewController?.view .addSubview(self.view())
    }
 }
