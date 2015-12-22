//
//  AppInfoUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/05.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

public class AppInfoUtil: NSObject {
    /**
    文字列からクラスを作成する
    
    - parameter className: クラス名
    
    - returns: 生成したクラス
    */
    public class func classFromString(
        className: String) -> AnyClass? {
        let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
            
        return classFromStringWithModule(appName, className: className)
    }
    
    /**
    外部モジュール名とクラス名を指定してクラスを生成する
    
    - parameter moduleName: モジュール名
    - parameter className:  クラス名
    
    - returns: 生成したクラス
    */
    public class func classFromStringWithModule(
        moduleName: String,
        className: String) -> AnyClass? {
            return NSClassFromString(moduleName + "." + className)
    }
    
    /**
     クラスからクラス名の文字列を取得
     
     - parameter object: 対象クラス
     
     - returns: クラス名
     */
    public class func classNameString(object: AnyClass) -> String? {
        if let className = NSStringFromClass(object).componentsSeparatedByString(".").last {
            return className
        }
        return nil
    }
}
