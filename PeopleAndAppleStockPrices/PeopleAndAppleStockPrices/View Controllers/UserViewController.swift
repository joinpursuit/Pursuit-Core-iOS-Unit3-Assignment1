//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    
    //MARK: -- Outlets
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    //MARK: -- Properties
    var users = [User]() {
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
        return users.filter { $0.name.fullName.lowercased().contains(searchedText.lowercased())}
    }
    
    //MARK: -- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.dataSource = self
        userSearchBar.delegate = self
        loadData()
    }
    
    private func loadData() {
        users = User.getUser()
        
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = segue.destination as? UserDetailViewController, let indexPath = userTableView.indexPathForSelectedRow else {
            return
        }
        location.users = users[indexPath.row]
    }

}

//MARK: -- Extensions

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = filteredUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = "\(user.name.firstName.capitalized) \(user.name.lastName.capitalized)"
        cell.detailTextLabel?.text = user.location.state.capitalized
        return cell
    }
    
}

extension UserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchedText = searchText
    }
}
