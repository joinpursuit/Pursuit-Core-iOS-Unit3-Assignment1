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
    
    var userContacts = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    //searchBar.delegate = self
    loadData()

  }

    func loadData() {
        userContacts = UserData.getUserData()
    }
     // func loadData() {
    //        let fileNameWars = "starWars"
    //        let ext = "json"
    //        let data = Bundle.readRawJSONData(filename: fileNameWars, ext: ext)
    //        episodes = MovieData.getEpisodes(from: data)
    //    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = userContacts[indexPath.row]
        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        cell.detailTextLabel?.text = contact.location.city.capitalized
        return cell
        
    }
}






    
