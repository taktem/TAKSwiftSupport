//
//  Parameterizable.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/16.
//
//

import UIKit

import ObjectMapper

public protocol Responsible: Mappable {
    
}

public extension Responsible {
    
}

/// 文字列から数値プロパティへ変換
class StringIntTransform: TransformType {
    typealias Object = Int
    typealias JSON = String
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        if let
            value = value as? String,
            intValue = Object(value) {
                return intValue
        } else {
            return 0
        }
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        return JSON(value)
    }
}