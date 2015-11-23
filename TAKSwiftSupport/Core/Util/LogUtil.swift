//
//  LogUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/11.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

/**
 デバッグ時のみ出力するログ 
 Pods内のOther Swift Flagsに-D DEBUGが必要
 */

public func DLog(message: AnyObject?,
    function: String = __FUNCTION__,
    line: Int = __LINE__,
    file: String = __FILE__) {
        #if DEBUG
            print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
        #endif
}

public func DLog(message: AnyObject,
    function: String = __FUNCTION__,
    line: Int = __LINE__,
    file: String = __FILE__) {
        #if DEBUG
            print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
        #endif
}

/**
 無条件で出力するログ
 */
public func ALog(message: AnyObject?,
    function: String = __FUNCTION__,
    line: Int = __LINE__,
    file: String = __FILE__) {
        print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
}

public func ALog(message: AnyObject,
    function: String = __FUNCTION__,
    line: Int = __LINE__,
    file: String = __FILE__) {
        print("[\(lastPass(fileName: file)):\(function) Line:\(line)] : \(message)" )
}

/**
 パス分割
 */
private func lastPass(fileName fileName: String) -> String {
    guard let lastPath = fileName.componentsSeparatedByString("/").last else {
        return ""
    }
    
    return lastPath
}