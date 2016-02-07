//
//  Comparable.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/10.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//
public extension Comparable {
    func clamp(min min: Self, max: Self) -> Self {
        if (self < min) {
            return min
        } else if (self > max) {
            return max
        } else {
            return self
        }
    }
}
