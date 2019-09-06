//
//  UsersViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    

    @IBOutlet weak var usersTableView: UITableView!
    
    @IBOutlet weak var usersSearchBar: UISearchBar!
    
    var users: [User]!
    
    var filteredUsers: [User] {
        get {
            guard let searchString = searchString else { return users }
            
            guard searchString != "" else { return users}
            
            return User.getFilteredResults(arr: users, searchText: searchString)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            self.usersTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        loadData()
    }
    
    private func configureTableView() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.rowHeight = 80
    }
    
    private func configureSearchBar() {
       usersSearchBar.delegate = self
    }
    
    private func loadData() {
        guard let pathToUsersFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError("Couldn't find file")}
        
        let url = URL(fileURLWithPath: pathToUsersFile)
        
        do {
            let data = try
                Data(contentsOf: url)
            let UsersFromJSON = try
                UserWrapper.getUsers(from: data)
            users = UsersFromJSON
            users = User.getSortedArray(arr: users)
            
        } catch {
            fatalError("Couldn't get Star Wars from JSON \(error)")
        }
    }
    

}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = filteredUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        cell.textLabel?.text = user.getFullName()
        cell.detailTextLabel?.text = user.getFullAddress()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "userSegue":
            guard let DetailVC = segue.destination as? UsersDetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = usersTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            
            let currentUser = filteredUsers[selectedIndexPath.row]
            
            DetailVC.user = currentUser
        default:
            fatalError("unexpected segue identifies")
        }
    }
    
    
}

extension UsersViewController: UITableViewDelegate {}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
