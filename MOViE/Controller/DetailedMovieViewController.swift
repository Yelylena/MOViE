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
import YouTubePlayer

class DetailedMovieViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var trailerLabel: UIButton!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?
    var basePosterPath = String()
    private var trailer: YouTubePlayerView?
    
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
        trailerLabel.addTarget(self, action: #selector(self.playTrailer), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        guard let id = movie?.id else {return}
        Alamofire.request("https://api.themoviedb.org/3/movie/\(id)/videos?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US").responseObject { (response: DataResponse<VideosResponse>) in
            debugPrint(response)

            if let videosResponse = response.result.value {
                for video in videosResponse.results! {
                    if video.type == "Trailer" {
                        self.trailer = YouTubePlayerView(frame: CGRect(x: 0, y: Int(self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.size.height), width: Int(UIScreen.main.bounds.size.width), height: Int(self.movieImage.frame.size.height)))
                        guard let key = video.key else {return}
                        self.trailer?.loadVideoID(key)
                        break
                    }
                }
            }
        }
    }
    
    @objc func playTrailer() {
        if trailer != nil {
            view.addSubview(trailer!)
            print(trailer?.frame.size.height)
        } else {
            let alert = UIAlertController(title: "", message: "No trailer", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
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
