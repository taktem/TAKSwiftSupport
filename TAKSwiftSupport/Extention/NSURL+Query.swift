//
//  NSURL+Query.swift
//  Pods
//
//  Created by 西村 拓 on 2015/11/22.
//
//

import UIKit

extension NSURL {
    
    var querys: [String: AnyObject]? {
        return getQuerys()
    }
    
    final private func getQuerys() -> [String: AnyObject]? {
        guard let query = query else {
            return [:]
        }
        
        // クエリ文字列を各パラメータ毎に分割
        let paramArray = query.componentsSeparatedByString("&")
        
        // クエリを辞書化
        var result = [String: String]()
        for param in paramArray {
            guard let param = param.stringByRemovingPercentEncoding else {
                continue
            }
            
            let kvs = param.componentsSeparatedByString("=")
            
            if kvs.count > 1 {
                result[kvs[0]] = kvs[1]
            }
        }
        
        return result
    }
    
    /**
    クエリーに対して直接アクセス
    
    - parameter key: Query Key String
    
    - returns: Value
    */
    subscript(key: String) -> String? {
        guard let querys = querys else {
            return nil
        }
        
        return querys[key] as? String
    }
}
