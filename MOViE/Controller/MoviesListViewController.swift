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


class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var moviesListTableView: UITableView!
    @IBOutlet weak var moviesListSearchBar: UISearchBar!
    
    private var moviesList = [MovieItem]()

    private var mainPageURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
//    private var currentPageURL = URL(string: "https://api.themoviedb.org/3/search/\(searchMovie!)api_key=<<api_key>>&language=en-US&page=1&include_adult=false")
    private var currentPage = 0
    private var basePosterPath = "https://image.tmdb.org/t/p/original"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.register(UINib(nibName: "ShortMovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShortMovieItemTableViewCell")
        moviesListSearchBar.delegate = self
        
        self.getData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MoviesListViewController.dismissKeyboard))
//        let test = UITapGestureRecognizer(target: self, action: <#T##Selector?#>)
        view.addGestureRecognizer(tap)
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchMovie = searchBar.text else {return}
        
        let searchURL = URL(string: "https://api.themoviedb.org/3/search/movie?query='\(searchMovie)'&api_key=<<api_key>>&language=en-US&page=1&include_adult=false")
        
        print(searchURL!)
        
        Alamofire.request(searchURL!).responseObject { (response: DataResponse<MovieDiscover>) in
            debugPrint(response)
            
            var list = [MovieItem]()
            
            if let movieResponse = response.result.value {
                for movie in (movieResponse.results)! {
                    list.append(movie)
                }
                self.currentPage = movieResponse.page!
            }
            DispatchQueue.main.async {
                self.moviesList = list
                self.moviesListTableView.reloadData()
            }
        }
//        self.
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedMovieSegue" {
            if let viewController = segue.destination as? DetailedMovieViewController {
                if let indexPath = moviesListTableView.indexPathForSelectedRow {
                    let movie = self.moviesList[indexPath.row]
                    viewController.movie = movie
                    viewController.basePosterPath = self.basePosterPath
                }
            }
        }
    }

}
