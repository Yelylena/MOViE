//
//  MoviesListViewController.swift
//  MOViE
//
//  Created by Yelylena on 15.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import SDWebImage


class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var moviesListSearchBar: UISearchBar!
    @IBOutlet weak var previousMovieButton: UIButton!
    @IBOutlet weak var nextMovieButton: UIButton!
    
    private var movieList = [Movie]()
    private var currentPage = 1
    
    private var mainPageURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=''&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
    private var currentPageURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=''&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
    
    private var basePagePath = "https://api.themoviedb.org/3/discover/movie?api_key=''&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="
    private var basePosterPath = "https://image.tmdb.org/t/p/original"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.register(UINib(nibName: "ShortMovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShortMovieItemTableViewCell")
        moviesListSearchBar.delegate = self
        
        self.getData()
        previousMovieButton.addTarget(self, action: #selector(self.showPreviousPage), for: .touchUpInside)
        nextMovieButton.addTarget(self, action: #selector(self.showNextPage), for: .touchUpInside)
        previousMovieButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        
        Alamofire.request(currentPageURL!).responseObject { (response: DataResponse<MovieDiscoverResponse>) in
            debugPrint(response)
            
            if let movieResponse = response.result.value {
                for movie in (movieResponse.results)! {
                    self.movieList.append(movie)
                    
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
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortMovieItemTableViewCell", for: indexPath) as! ShortMovieItemTableViewCell
        
        if movieList.count > indexPath.row {
            let movie = self.movieList[indexPath.row]

            if let backdropPath = movie.backdropPath {
                let fullPosterPath = basePosterPath + backdropPath
                cell.movieImage.sd_setImage(with: URL(string: fullPosterPath))
            } else {
                cell.movieImage.sd_setImage(with: URL(string: ""))
            }
            cell.movieTitle.text = movie.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailedMovieSegue", sender: nil)
    }
    
    func getAndReloadData(url: URL?) {
        currentPageURL = url
        movieList = [Movie]()
        self.getData()
        self.moviesListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchMovie = searchBar.text else {return}
        
        let searchURL = URL(string: "https://api.themoviedb.org/3/search/movie?query='\(searchMovie)'&api_key=''&language=en-US&page=1&include_adult=false")
        
        self.getAndReloadData(url: searchURL)
        
        view.endEditing(true)
    }
    
    @objc func showPreviousPage(_ sender: UIButton) {
        let previousPageURL = URL(string: basePagePath + "\(currentPage - 1)")

        if currentPage > 1 {
            self.getAndReloadData(url: previousPageURL)
        }
        
        if currentPageURL == mainPageURL {
            self.previousMovieButton.isEnabled = false
        }
        
    }
    
    @objc func showNextPage(_ sender: UIButton) {
    
        let nextPageURL = URL(string: basePagePath + "\(currentPage + 1)")
        
        self.getAndReloadData(url: nextPageURL)
        
        self.previousMovieButton.isEnabled = true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedMovieSegue" {
            if let viewController = segue.destination as? DetailedMovieViewController {
                if let indexPath = moviesListTableView.indexPathForSelectedRow {
                    let movie = self.movieList[indexPath.row]
                    viewController.movie = movie
                    viewController.basePosterPath = self.basePosterPath
                }
            }
        }
    }

}
