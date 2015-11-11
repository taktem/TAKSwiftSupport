//
//  Easing.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/10.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import Foundation

public enum EasingType: String {
    case Unknown = "Unknown"
    case NoAnimation = "NoAnimation"
    case Linear = "Linear"
    case EaseInOut = "EaseInOut"
}

/// イージングタイプと時間パラメータを指定して値と取得する
public class Easing: NSObject {
    public class func timeToEasingCarve(
        type type: EasingType,
        var time: CGFloat,
        startValue: CGFloat,
        changeValue: CGFloat,
        duration: CGFloat) -> CGFloat {
            
            if time < 0.0 {
                time = 0.0
            }
            
            switch type {
            case .Unknown:
                return startValue
                
            case .NoAnimation:
                return changeValue
                
            case .Linear:
                return timeToEasingCarveLinear(
                    time: time,
                    startValue: startValue,
                    changeValue: changeValue,
                    duration: duration)
                
            case .EaseInOut:
                return timeToEasingCarveEaseInOut(
                    time: time,
                    startValue: startValue,
                    changeValue: changeValue,
                    duration: duration)
            }
    }
    
    /**
     Linear
     */
    private class func timeToEasingCarveLinear(
        time time: CGFloat,
        startValue: CGFloat,
        changeValue: CGFloat,
        duration: CGFloat) -> CGFloat {
            return changeValue / duration * time + startValue
    }
    
    /**
     EaseInOut
     */
    private class func timeToEasingCarveEaseInOut(
        time time: CGFloat,
        startValue: CGFloat,
        changeValue: CGFloat,
        duration: CGFloat) -> CGFloat {
            return changeValue / duration * time + startValue
    }
}
