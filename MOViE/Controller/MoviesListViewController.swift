//
//  MoviesListViewController.swift
//  MOViE
//
//  Created by Yelylena on 15.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.register(UINib(nibName: "ShortMovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShortMovieItemTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortMovieItemTableViewCell", for: indexPath) as! ShortMovieItemTableViewCell
        
        return cell
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
