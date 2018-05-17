//
//  MovieDiscover.swift
//  MOViE
//
//  Created by Yelylena on 17.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation

struct MovieDiscover: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    var page: Int?
    var results: [[String: Any]]?
    var totalResults: Int?
    var totalPages: Int?
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let page = representation["page"] as? Int,
            let results = representation["results"] as? [[String: Any]],
            let totalResults = representation["total_results"] as? Int,
            let totalPages = representation["total_pages"] as? Int
        else { return nil }
        
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
    
}
