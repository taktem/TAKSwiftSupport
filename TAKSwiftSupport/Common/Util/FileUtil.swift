//
//  FileUtil.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/06.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

/// ファイル操作に関するUtil
public class FileUtil: NSObject {

    //MARK: - Plist
    /**
    plistファイルから配列を読み込む
    
    - parameter plistFileName: ファイル名
    
    - returns: NSArray
    */
    public class func loadPlistArray(plistFileName plistFileName: String) -> NSArray {
        if let
            filePath = NSBundle.mainBundle().pathForResource(plistFileName, ofType: "plist"),
            source = NSArray(contentsOfFile: filePath) {
                return source
        }
        
        return []
    }
    
    /**
    plistファイルから辞書を読み込む
    
    - parameter plistFileName: ファイル名
    
    - returns: NSDictionary
    */
    public class func loadPlistDictionary(plistFileName plistFileName: String) -> NSDictionary {
        if let
            filePath = NSBundle.mainBundle().pathForResource(plistFileName, ofType: "plist"),
            source = NSDictionary(contentsOfFile: filePath) {
                return source
        }
        
        return [:]
    }
}
