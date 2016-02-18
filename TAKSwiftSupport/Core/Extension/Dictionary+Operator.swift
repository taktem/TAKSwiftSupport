//
//  Dictionary+Operator.swift
//  Pods
//
//  Created by 西村 拓 on 2016/02/18.
//
//

import UIKit

/// Dictionary結合用
public extension Dictionary {
    mutating func unionInPlace(dictionary: Dictionary) {
        dictionary.forEach { self[$0] = $1 }
    }
    
    func union(var dictionary: Dictionary) -> Dictionary {
        dictionary.unionInPlace(self)
        return dictionary
    }
}

public func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var result = Dictionary<K,V>()
    
    left.forEach { result[$0] = $1 }
    right.forEach { result[$0] = $1 }
    
    return result
}

public func += <K, V> (inout left: Dictionary<K,V>, right: Dictionary<K,V>) {
    right.forEach { left[$0] = $1 }
}
