//
//  MovieListTableViewController.swift
//  MOViE
//
//  Created by Yelylena on 02.07.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import SDWebImage

class MovieListTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController!
    
    private var movieList = [Movie]()
    private var searchResults = [Movie]()
    private var currentPageIndex = 1
    
    private var basePagePath = "https://api.themoviedb.org/3/discover/movie?api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="
    private var basePosterPath = "https://image.tmdb.org/t/p/original"
    
    private var mainPageURL: URL!
    private var currentPageURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPageURL = URL(string: basePagePath + "1")
        currentPageURL = URL(string: basePagePath + "\(currentPageIndex)")
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ShortMovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShortMovieItemTableViewCell")
        
        getData()
        print(movieList.count)
        
        // Adding a search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movie..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
        tableView.tableHeaderView = searchController.searchBar
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Get data
    
    func getData() {
        Alamofire.request(currentPageURL!).responseObject { (response: DataResponse<MovieDiscoverResponse>) in
            debugPrint(response)
            
            if let movieResponse = response.result.value {
                for movie in (movieResponse.results)! {
                    self.movieList.append(movie)
                }
                self.currentPageIndex = movieResponse.page!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getAndReloadData(url: URL?) {
        currentPageURL = url
        movieList = [Movie]()
        getData()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return searchController.isActive ? searchResults.count : movieList.count
        return movieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortMovieItemTableViewCell", for: indexPath) as! ShortMovieItemTableViewCell
        
        if movieList.count > indexPath.row {
            let movie = self.movieList[indexPath.row]
            
            if let backdropPath = movie.backdropPath {
                let fullPosterPath = basePosterPath + backdropPath
                cell.movieImageView.sd_setImage(with: URL(string: fullPosterPath))
            } else {
                cell.movieImageView.sd_setImage(with: URL(string: ""))
            }
            cell.titleLabel.text = movie.title
            cell.ratingLabel.text = String(format: "%.0f", movie.voteAverage! * 10) + "%"
            cell.dateLabel.text = movie.releaseDate
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return searchController.isActive ? false : true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailMovieSegue", sender: nil)
    }
    
    // MARK: - Helper methods
    
    func filterContent(for searchText: String) {
        
        let searchURL = URL(string: "https://api.themoviedb.org/3/search/movie?query='\(searchText)'&api_key=bebe2550a271cb5b5afd5d7a31c80926&language=en-US&page=1&include_adult=false")
        
        self.getAndReloadData(url: searchURL)
        
        view.endEditing(true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailMovieSegue" {
            if let viewController = segue.destination as? MovieDetailTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let movie = self.movieList[indexPath.row]
                    viewController.movie = movie
                    viewController.basePosterPath = self.basePosterPath
                    viewController.hidesBottomBarWhenPushed = true
                }
            }
        }
    }

}
