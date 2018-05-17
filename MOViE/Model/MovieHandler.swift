//
//  MovieHandler.swift
//  MOViE
//
//  Created by Yelylena on 16.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class MovieHandler {
    
    func getMovieDiscover() {

//        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
//        }
        
        
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").responseObject { (response: DataResponse<MovieDiscover>) in
            debugPrint("error")
            
            if let movieDiscover = response.result.value {
                print("\(movieDiscover.page ?? 0)" + "\(movieDiscover.totalResults)" + "\(movieDiscover.totalPages)" + "\n")
                
                for movie in movieDiscover.results! {
                    print(movie)
                }
            }
        }
        
        
//        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").responseCollection { (response: DataResponse<[MovieItem]>) in
//            debugPrint(response)
//
//            if let moviesList = response.result.value {
//                print(moviesList.count)
//            }
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//        }
        
    }
    
}
