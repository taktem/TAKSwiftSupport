//
//  RealmManager.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RealmSwift

public class RealmManager: NSObject {
    
    final private class func realm() -> Realm {
        
        let realm = try! Realm()
        return realm
    }
    
//    final public func object<T: Object>() -> T {
//        
//    }
    
    final public class func add<T: Object>(object object: T) {
        realm().add(object)
    }
}
