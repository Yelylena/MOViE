//
//  Extensions.swift
//  MOViE
//
//  Created by Yelylena on 18.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


extension MovieDiscover {
    
    func getResponse(url: URL) -> [MovieItem]{
        
        var movieList = [MovieItem]()
        
        Alamofire.request(url).responseObject { (response: DataResponse<MovieDiscover>) in
            debugPrint(response)
            
            if let movieResponse = response.result.value {
                for movie in (movieResponse.results)! {
                    movieList.append(movie)
                }
            }
        }
        return movieList
    }
}
