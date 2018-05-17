//
//  MovieItem.swift
//  MOViE
//
//  Created by Yelylena on 16.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import ObjectMapper

struct MovieItem: Mappable {

    var posterPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds:[Int]?
    var id: Int?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        posterPath       <- map["poster_path"]
        adult            <- map["adult"]
        overview         <- map["overview"]
        releaseDate      <- map["release_date"]
        genreIds         <- map["genre_ids"]
        id               <- map["id"]
        originalTitle    <- map["original_title"]
        originalLanguage <- map["original_language"]
        title            <- map["title"]
        backdropPath     <- map["backdrop_path"]
        popularity       <- map["popularity"]
        voteCount        <- map["vote_count"]
        video            <- map["video"]
        voteAverage      <- map["vote_average"]
    }
}
