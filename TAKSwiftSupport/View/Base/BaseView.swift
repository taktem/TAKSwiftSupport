 //
//  BaseView.swift
//  hero
//
//  Created by 西村 拓 on 2015/09/19.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

class BaseView: UIView {

    /**
    クラス名と同名のxibファイルからUIViewを生成
    
    - returns: UIView
    */
    class func view() -> UIView {
        return UINib(nibName: NSStringFromClass(self), bundle: NSBundle.mainBundle()).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func show() {
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
        window.rootViewController?.view .addSubview(self.view())
    }
}
