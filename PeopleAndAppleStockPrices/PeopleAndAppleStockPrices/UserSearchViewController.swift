//
//  UserSearchViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var results = [ResultsToSet]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredUsers = [ResultsToSet]()
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsers = results.filter({( user : ResultsToSet) -> Bool in
              return user.name.first.contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewControllre,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        let user = results[indexPath.row]
        destination.resultToSet = user
    }
    func loadData() {
       if let filePath = Bundle.main.path(forResource: "userinfo", ofType: "json") {
           let myUrl = URL.init(fileURLWithPath: filePath)
            if let data = try? Data.init(contentsOf: myUrl){
                do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                   results = user.results
                    print(results)
                }catch{
                    print("error is: \(error)")
                }
            }
        }
    }
}
extension UserSearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredUsers.count
        }
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        var userToSet: ResultsToSet
        
        if isFiltering() {
            userToSet = filteredUsers[indexPath.row]
        } else {
            userToSet = results[indexPath.row]
        }
        cell.textLabel?.text = userToSet.name.first.capitalized + " " + userToSet.name.last.capitalized
       cell.detailTextLabel?.text = userToSet.location.city.capitalized + " " + userToSet.location.street.capitalized
        cell.detailTextLabel?.text = userToSet.location.city.capitalized
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUserDetail", sender: indexPath.row)
    }
}
extension UserSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

