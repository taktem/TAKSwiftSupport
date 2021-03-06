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
     バンドルIDを取得する
     */
    public final class func bundleIdentifier() -> String {
        if let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier {
            return bundleIdentifier
        } else {
            return ""
        }
    }
    
    /**
    文字列からクラスを作成する
    
    - parameter className: クラス名
    
    - returns: 生成したクラス
    */
    public final class func classFromString(
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
    
    /**
     実行中のデバイスを取得
     */
    public class func deviceType() -> DeviceType {
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        
        if let
            deviceName = String.fromCString(machine),
            deviceType = DeviceType(rawValue: deviceName) {
                return deviceType
        } else {
            return .UnKnown
        }
    }
}
