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
            if let scopeTitles = searchOutlet.scopeButtonTitles {
                let currentScopeIndex = searchOutlet.selectedScopeButtonIndex
                
                switch scopeTitles[currentScopeIndex] {
                case "First Name":
                    let results = totalPeople.filter( {$0.name.first.lowercased().contains(searchString!.lowercased())})
                    return results
                   
                case "Last Name":
                let results = totalPeople.filter( {$0.name.last.lowercased().contains(searchString!.lowercased())})
                return results
                default:
                    return totalPeople
            }
        }
            return totalPeople
    }
}
            
            
    @IBOutlet weak var userTableOutlet: UITableView!
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableOutlet.dequeueReusableCell(withIdentifier: "user")
        
        cell?.textLabel?.text = User.formattedName(index: indexPath.row, userArray: userSearchResults)
        cell?.detailTextLabel?.text = User.formattedAddress(index: indexPath.row, userArray: userSearchResults)
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
        userDetailVC.person = totalPeople[userTableOutlet.indexPathForSelectedRow!.row]
    }
    
    private func LoadData() {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let userDataFromJSON = try UserWrapper.getUserData(from: data)
            totalPeople = userDataFromJSON
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

