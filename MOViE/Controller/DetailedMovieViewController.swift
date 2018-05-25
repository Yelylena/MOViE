//
//  DetailedMovieViewController.swift
//  MOViE
//
//  Created by Yelylena on 18.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import AlamofireObjectMapper

class DetailedMovieViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var trailerLabel: UIButton!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?
    var basePosterPath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let backdropPath = movie?.backdropPath {
            let fullPosterPath = basePosterPath + backdropPath
            movieImage.sd_setImage(with: URL(string: fullPosterPath))
        } else {
            movieImage.sd_setImage(with: URL(string: ""))
        }

        self.getData()
        
        self.movieTitle.text = self.movie?.title
        self.popularity.text = String(format: "%.0f", (self.movie?.voteAverage)! * 10) + "%"
        self.overview.text = self.movie?.overview
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        guard let id = movie?.id else {return}
        Alamofire.request("https://api.themoviedb.org/3/movie/\(id)/videos?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US").responseObject { (response: DataResponse<VideosResponse>) in
            debugPrint(response)

//            if let videosResponse = response.result.value {
//
//            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
