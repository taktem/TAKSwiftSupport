//
//  RealmObjectable.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/11/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RealmSwift
import Realm
import Realm.Private

import ObjectMapper

public class RealmObject:Object, RealmObjectable {
    required public convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }

    required public init() {
        super.init()
    }
    
    override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    public func mapping(map: Map) {
        
    }
    
    final public class func mapping<T: RealmObject>(map map: [String: AnyObject]) -> T? {
        return Mapper<T>().map(map)
    }
}


public protocol RealmObjectable: Mappable {
    
}

public extension Responsible {
    
}