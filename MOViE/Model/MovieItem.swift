//
//  MovieItem.swift
//  MOViE
//
//  Created by Yelylena on 16.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

struct MovieItem: ResponseObjectSerializable, ResponseCollectionSerializable {
    
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
    
//    init(originalTitle: String, releaseDate: String) {
//        self.originalTitle = originalTitle
//        self.releaseDate = releaseDate
//    }
//
//    init() {
//        originalTitle = String()
//        releaseDate = String()
//    }
    init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: Any] else {return nil}
        guard let posterPath = representation["poster_path"] as? String else {return nil}
        guard let adult = representation["adult"] as? Bool else {return nil}
        guard let overview = representation["overview"] as? String else {return nil}
        guard let releaseDate = representation["release_date"] as? String else {return nil}
        guard let genreIds = representation["genre_ids"] as?[Int] else {return nil}
        guard let id = representation["id"] as? Int else {return nil}
        guard let originalTitle = representation["original_title"] as? String else {return nil}
        guard let originalLanguage = representation["original_language"] as? String else {return nil}
        guard let title = representation["title"] as? String else {return nil}
        guard let backdropPath = representation["backdrop_path"] as? String else {return nil}
        guard let popularity = representation["popularity"] as? Double else {return nil}
        guard let voteCount = representation["vote_count"] as? Int else {return nil}
        guard let video = representation["video"] as? Bool else {return nil}
        guard let voteAverage = representation["vote_average"] as? Double else {return nil}
//        guard
//            let representation = representation as? [String: Any],
//            let posterPath = representation["poster_path"] as? String,
//            let adult = representation["adult"] as? Bool,
//            let overview = representation["overview"] as? String,
//            let releaseDate = representation["release_date"] as? String,
//            let originalTitle = representation["original_title"] as? String,
//            let genreIds = representation["genre_ids"] as?[Int]
//            else { return nil }
        
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
}
