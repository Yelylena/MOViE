//
//  MovieDiscover.swift
//  MOViE
//
//  Created by Yelylena on 17.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieDiscover: Mappable {
    
    var page: Int?
    var results: [MovieItem]?
    var totalResults: Int?
    var totalPages: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        page         <- map["page"]
        results      <- map["results"]
        totalResults <- map["total_results"]
        totalPages   <- map["total_pages"]
    }
   
    
//    init?(response: HTTPURLResponse, representation: Any) {
//        guard
//            let representation = representation as? [String: Any],
//            let page = representation["page"] as? Int,
//            let results = representation["results"] as? [[String: Any]],
//            let totalResults = representation["total_results"] as? Int,
//            let totalPages = representation["total_pages"] as? Int
//        else { return nil }
    
//        self.page = page
//        self.results = results
//        self.totalResults = totalResults
//        self.totalPages = totalPages
//    }
    
}
