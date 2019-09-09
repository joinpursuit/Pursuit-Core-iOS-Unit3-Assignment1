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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        
        let subtitleCell = userTableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
        subtitleCell.textLabel?.text = user.name.fullName
        subtitleCell.detailTextLabel?.text = user.location.address
        return subtitleCell
    }
}

extension UsersTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
