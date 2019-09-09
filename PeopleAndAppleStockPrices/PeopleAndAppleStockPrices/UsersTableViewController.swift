//
//  UsersTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UsersTableViewController: UIViewController {

    var users = [User](){
        didSet {
            userTableView.reloadData()
        }
    }

    var searchedText = "" {
        didSet {
            userTableView.reloadData()
        }
    }
    
    var filteredUsers: [User] {
        guard searchedText != "" else {
            return users
        }
        return users.filter{ $0.name.fullName.lowercased().contains(searchedText.lowercased())
        }
    }
    
    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        userTableView.dataSource = self
        usersSearchBar.delegate = self
    }
    
    private func loadUsers() {
        users = User.getUsers()
    }
}

extension UsersTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = filteredUsers[indexPath.row]
        
        let subtitleCell = userTableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
        subtitleCell.textLabel?.text = user.name.fullName.capitalized
        subtitleCell.detailTextLabel?.text = user.location.address
        return subtitleCell
    }
}

extension UsersTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchText
    }
}
