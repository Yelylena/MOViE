//
//  SearchResultItem.swift
//  MOViE
//
//  Created by Yelylena on 21.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchResultItem {
    var page: Int?
    var id: Int?
    var name: String?
    var totalResults: Int?
    var totalPages: Int?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        page         <- map["page"]
        id           <- map["id"]
        name         <- map["name"]
        totalResults <- map["total_results"]
        totalPages   <- map["total_pages"]
    }
}
