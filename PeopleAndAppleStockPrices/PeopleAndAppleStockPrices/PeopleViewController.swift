//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    searchBar.delegate = self
    loadData()

  }

    func loadData() {
        
    }

}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
    }
}

//class StarWarsViewController: UIViewController {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var episodes = [Episode](){
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        loadData()
//    }
//    
//    func loadData() {
//        let fileNameWars = "starWars"
//        let ext = "json"
//        let data = Bundle.readRawJSONData(filename: fileNameWars, ext: ext)
//        episodes = MovieData.getEpisodes(from: data)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let detailMovieVC = segue.destination as? DetailStarWarsViewController, let indexPath = tableView.indexPathForSelectedRow else {
//            fatalError("verify class name in identity inspector")
//        }
//        let episode = episodes[indexPath.row]
//        detailMovieVC.someEpisode = episode
//    }
//}
//
//extension StarWarsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        episodes.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "starWarsCell", for: indexPath)
//        
//        let episode = episodes[indexPath.row]
//        cell.textLabel?.text = episode.title
//        return cell
//    }
//}



    
