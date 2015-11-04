//
//  GMSMarkerEntity.swift
//  TAKSwiftSupport
//
//  Created by 西村 拓 on 2015/10/12.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import ObjectMapper

public class GMSMarkerEntity: NSObject, Mappable {
    var name = ""
    var snippet = ""
    var latitude = 0.0
    var longitude = 0.0

    var iconImage: UIImage?
    var userData: [String : AnyObject]?
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        snippet <- map["snippet"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
