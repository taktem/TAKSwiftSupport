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
    
    final public func add<T: Object>(object object: T) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object)
        }
    }
    
    final public func readAll<T: RealmObject>() -> Results<T> {
        let realm = try! Realm()
        let result = realm.objects(T)
        
        return result
    }
    
    final public func readEntity<T: RealmObject>(key key: String, value: String) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(T).filter("\(key) = '\(value)'")
    }
    
    final public func deleteObject(object: RealmObject) {
        let realm = try! Realm()
        try!  realm.write {
            realm.delete(object)
        }
    }
}
