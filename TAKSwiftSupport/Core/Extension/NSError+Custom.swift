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
    
    public enum CustomErrorType: Int {
        case Unknown = -1
        
        // Network
        case JsonMappingError = -999
        
        func localizedDescription() -> String {
            switch self {
            case .Unknown:
                return "Unknown Error"
                
            case .JsonMappingError:
                return "Unable to convert data to string"
            }
        }
    }
    
    /**
     エラータイプを指定してNSError作成
     */
    public convenience init(errorType: CustomErrorType) {
        self.init(
            domain: AppInfoUtil().bundleIdentifier(),
            code: errorType.rawValue,
            userInfo: [NSLocalizedDescriptionKey: errorType.localizedDescription()])
    }
    
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
