//
//  MoviesListViewController.swift
//  MOViE
//
//  Created by Yelylena on 15.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SDWebImage


class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    private var moviesList = [MovieItem]()
    
    private var mainPageURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.register(UINib(nibName: "ShortMovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShortMovieItemTableViewCell")
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        Alamofire.request(mainPageURL!).responseObject { (response: DataResponse<MovieDiscover>) in
            debugPrint(response)
            
            if let movieResponse = response.result.value {
                for movie in (movieResponse.results)! {
                    self.moviesList.append(movie)
                    
                }
                self.currentPage = movieResponse.page!
            }
            DispatchQueue.main.async {
                self.moviesListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortMovieItemTableViewCell", for: indexPath) as! ShortMovieItemTableViewCell
        
        if moviesList.count > indexPath.row {
            let movie = self.moviesList[indexPath.row]
            let fullPosterPath = "https://image.tmdb.org/t/p/w700_and_h392_bestv2" + String(movie.backdropPath!)
        
            cell.movieImage.sd_setImage(with: URL(string: fullPosterPath))
            cell.movieTitle.text = movie.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailedMovieSegue", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedMovieSegue" {
            if let viewController = segue.destination as? DetailedMovieViewController {
                if let indexPath = moviesListTableView.indexPathForSelectedRow {
                    let movie = self.moviesList[indexPath.row]
                    viewController.movie = movie
                }
            }
        }
    }

}
