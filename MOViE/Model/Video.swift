//
//  Video.swift
//  MOViE
//
//  Created by Yelylena on 23.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation
import ObjectMapper

struct Video {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id     <- map["id"]
        key    <- map["key"]
        name   <- map["name"]
        site   <- map["site"]
        size   <- map["size"]
        type   <- map["type"]
    }
}
