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
    
    var movie: MovieItem?
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
        Alamofire.request("").responseObject { (response: DataResponse<MovieItem>) in
            debugPrint(response)

            if let movieResponse = response.result.value {

            }
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
