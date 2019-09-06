//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var totalPeople = [User]()
    var searchString: String? = nil {
        didSet {
            self.userTableOutlet.reloadData()
        }
    }
   
    var userSearchResults: [User] {
        get {
            guard let _ = searchString else {
                return totalPeople
            }
            guard searchString != "" else {
                return totalPeople
            }
                    let results = totalPeople.filter( {$0.name.fullname.lowercased().contains(searchString!.lowercased())  })
                    return results
            }
        }

            
            
    @IBOutlet weak var userTableOutlet: UITableView!
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableOutlet.dequeueReusableCell(withIdentifier: "user")
        cell?.textLabel?.text = userSearchResults[indexPath.row].name.fullname
        cell?.detailTextLabel?.text = userSearchResults[indexPath.row].location.fullAddress
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchOutlet.resignFirstResponder()
        searchString = searchOutlet.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDetailVC = segue.destination as? UserDetailViewController else { fatalError() }
        userDetailVC.person = userSearchResults[userTableOutlet.indexPathForSelectedRow!.row]
    }
    
    private func LoadData() {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let userDataFromJSON = try UserWrapper.getUserData(from: data)
            totalPeople = userDataFromJSON.sorted(by: {(person1, person2) -> Bool in
                (person1.name.first + person1.name.last) < (person2.name.first + person2.name.last)
            })
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    userTableOutlet.delegate = self
    userTableOutlet.dataSource = self
    searchOutlet.delegate = self
    LoadData()
  }


}

