//
//  DetailedMovieViewController.swift
//  MOViE
//
//  Created by Yelylena on 18.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import SDWebImage

class DetailedMovieViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    var movie: MovieItem?
    var basePosterPath = "https://image.tmdb.org/t/p/w700_and_h392_bestv2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieImage.sd_setImage(with: URL(string: basePosterPath + (self.movie?.backdropPath!)!))
        self.movieTitle.text = self.movie?.title
        self.popularity.text = String(format: "%.0f", (self.movie?.voteAverage)! * 10) + "%"
        self.overview.text = self.movie?.overview
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
