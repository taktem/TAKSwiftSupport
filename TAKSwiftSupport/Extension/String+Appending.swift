//
//  String+Appending.swift
//  Pods
//
//  Created by 西村 拓 on 2015/12/18.
//
//

import UIKit

/// String結合Extension
public extension String {
    
    /// URL Pathパターン
    func append(pathComponent pathComponent: String) -> String? {
        guard let url = NSURL(string: self) else {
            return nil
        }
        
        return url.URLByAppendingPathComponent(pathComponent).absoluteString
    }
}
