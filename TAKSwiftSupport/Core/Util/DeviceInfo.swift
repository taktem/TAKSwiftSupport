//
//  DeviceInfo.swift
//  Pods
//
//  Created by 西村 拓 on 2016/02/17.
//
//

import UIKit

/**
 デバイス名
 */
public enum DeviceType: String {
    case UnKnown    = ""
    case iPhone4_1  = "iPhone4,1"
    case iPhone5_1  = "iPhone5,1"
    case iPhone5_2  = "iPhone5,2"
    case iPhone5_3  = "iPhone5,3"
    case iPhone5_4  = "iPhone5,4"
    case iPhone6_1  = "iPhone6,1"
    case iPhone6_2  = "iPhone6,2"
    case iPhone7_1  = "iPhone7,1"
    case iPhone7_2  = "iPhone7,2"
    case iPad1_1    = "iPad1,1"
    case iPad2_1    = "iPad2,1"
    case iPad2_2    = "iPad2,2"
    case iPad2_3    = "iPad2,3"
    case iPad2_4    = "iPad2,4"
    case iPad2_5    = "iPad2,5"
    case iPad2_6    = "iPad2,6"
    case iPad2_7    = "iPad2,7"
    case iPad3_1    = "iPad3,1"
    case iPad3_2    = "iPad3,2"
    case iPad3_3    = "iPad3,3"
    case iPad3_4    = "iPad3,4"
    case iPad3_5    = "iPad3,5"
    case iPad3_6    = "iPad3,6"
    case iPad4_1    = "iPad4,1"
    case iPad4_2    = "iPad4,2"
    case iPad4_3    = "iPad4,3"
    case iPad4_4    = "iPad4,4"
    case iPad4_5    = "iPad4,5"
    case iPad4_6    = "iPad4,6"
    case iPad4_7    = "iPad4,7"
    case iPad4_8    = "iPad4,8"
    case iPad4_9    = "iPad4,9"
    case iPad5_3    = "iPad5,3"
    case iPad5_4    = "iPad5,4"
    case iPod1_1    = "iPod1,1"
    case iPod2_1    = "iPod2,1"
    case iPod3_1    = "iPod3,1"
    case iPod4_1    = "iPod4,1"
    case iPod5_1    = "iPod5,1"
    
    /**
     機種名詳細
     */
    func name() -> String {
        switch self {
        case UnKnown: return ""
        case iPhone4_1: return "iPhone 4S"
        case iPhone5_1: return "iPhone 5 (A1428)"
        case iPhone5_2: return "iPhone 5 (A1429)"
        case iPhone5_3: return "iPhone 5c (A1456/A1532)"
        case iPhone5_4: return "iPhone 5c (A1507/A1516/A1529)"
        case iPhone6_1: return "iPhone 5s (A1433/A1453)"
        case iPhone6_2: return "iPhone 5s (A1457/A1518/A1530)"
        case iPhone7_1: return "iPhone 6 Plus"
        case iPhone7_2: return "iPhone 6"
        case iPad1_1: return "iPad"
        case iPad2_1: return "iPad 2 (Wi-Fi)"
        case iPad2_2: return "iPad 2 (GSM)"
        case iPad2_3: return "iPad 2 (CDMA)"
        case iPad2_4: return "iPad 2 (Wi-Fi, revised)"
        case iPad2_5: return "iPad mini (Wi-Fi)"
        case iPad2_6: return "iPad mini (A1454)"
        case iPad2_7: return "iPad mini (A1455)"
        case iPad3_1: return "iPad (3rd gen, Wi-Fi)"
        case iPad3_2: return "iPad (3rd gen, Wi-Fi+LTE Verizon)"
        case iPad3_3: return "iPad (3rd gen, Wi-Fi+LTE AT&T)"
        case iPad3_4: return "iPad (4th gen, Wi-Fi)"
        case iPad3_5: return "iPad (4th gen, A1459)"
        case iPad3_6: return "iPad (4th gen, A1460)"
        case iPad4_1: return "iPad Air (Wi-Fi)"
        case iPad4_2: return "iPad Air (Wi-Fi+LTE)"
        case iPad4_3: return "iPad Air (Rev)"
        case iPad4_4: return "iPad mini 2 (Wi-Fi)"
        case iPad4_5: return "iPad mini 2 (Wi-Fi+LTE)"
        case iPad4_6: return "iPad mini 2 (Rev)"
        case iPad4_7: return "iPad mini 3 (Wi-Fi)"
        case iPad4_8: return "iPad mini 3 (A1600)"
        case iPad4_9: return "iPad mini 3 (A1601)"
        case iPad5_3: return "iPad Air 2 (Wi-Fi)"
        case iPad5_4: return "iPad Air 2 (Wi-Fi+LTE)"
        case iPod1_1: return "iPod touch"
        case iPod2_1: return "iPod touch (2nd gen)"
        case iPod3_1: return "iPod touch (3rd gen)"
        case iPod4_1: return "iPod touch (4th gen)"
        case iPod5_1: return "iPod touch (5th gen)"
        }
    }
}