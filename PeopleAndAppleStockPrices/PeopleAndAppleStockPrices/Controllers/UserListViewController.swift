//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userListTableView: UITableView!
    
    var allUsers = [User]() {
        didSet { self.userListTableView.reloadData() }
    }
    
    var searchString: String? = nil {
        didSet { self.userListTableView.reloadData() }
    }
    
    var userSearchResults: [User] {
        get {
            guard let searchString = searchString else { return allUsers }
            guard searchString != "" else { return allUsers }
            
            let filterUserArr = allUsers.filter {$0.getFullName(firstName: $0.name.firstName, lastName: $0.name.lastName).lowercased().contains(searchString.lowercased())}

            return filterUserArr
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        loadUserData()
    }
    
    private func configureTableView() {
        userListTableView.dataSource = self
        userListTableView.delegate = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func loadUserData() {
        let userData = DataAPIClient.getUserDataFromJSON()
        // refactor later to not force unwrap?
        allUsers = UserWrapper.getAllUsers(from: userData)!.results
    }
    
    //refactor to not use fatalerror
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = userListTableView.indexPathForSelectedRow else { fatalError("No cell was selected") }
        guard segue.identifier == "userCellToDetailSegue" else { fatalError("Unidentified segue") }
        guard let userDetailsVC = segue.destination as? UserDetailViewController else { fatalError("No destination View Controller") }
        
        userDetailsVC.user = allUsers[selectedIndex.row]
    }

}

extension UserListViewController: UITableViewDelegate {}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = userSearchResults[indexPath.row]
        let userCell = userListTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        //refactor to capitalize name in models
        userCell.textLabel?.text = currentUser.getFullName(firstName: currentUser.name.firstName, lastName: currentUser.name.lastName)
        userCell.detailTextLabel?.text = currentUser.location.state.capitalized
        
        return userCell
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
