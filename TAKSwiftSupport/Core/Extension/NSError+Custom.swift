//
//  NSError+Custom.swift
//  Pods
//
//  Created by 西村 拓 on 2016/01/28.
//
//

import UIKit

/// NSError汎用
public extension NSError {
    
    /**
     ステータスコードとエラーメッセージを指定してNSError生成
     
     - parameter code:                 ステータスコード
     - parameter localizedDescription: エラーメッセージ
     */
    public convenience init(code: Int, localizedDescription: String) {
        self.init(
            domain: AppInfoUtil().bundleIdentifier(),
            code: code,
            userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
