//
//  Video.swift
//  MOViE
//
//  Created by Yelylena on 23.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation
import ObjectMapper

struct VideosResponse: Mappable {
    
    var id: Int?
    var results: [Video]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id         <- map["id"]
        results    <- map["results"]
    }
}

struct Video: Mappable {
    var id: String?
    var iso_639_1: String?
    var iso_3166_1: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id         <- map["id"]
        iso_639_1  <- map["iso_639_1"]
        iso_3166_1 <- map["iso_3166_1"]
        key        <- map["key"]
        name       <- map["name"]
        site       <- map["site"]
        size       <- map["size"]
        type       <- map["type"]
    }
}
