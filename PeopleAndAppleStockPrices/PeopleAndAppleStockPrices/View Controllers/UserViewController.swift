//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.dataSource = self
        userSearchBar.delegate = self 
        loadData()
    }
    
    
    //MARK: -- Properties
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    
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
    
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: ".json") else {
            print("Error finding JSON file")
            return
        }
        
        let url =  URL(fileURLWithPath: pathToJSONFile)
        
        do {
            let data = try Data(contentsOf: url)
            let usersFromJSON = try User.getUser(from: data)
            users = usersFromJSON
        } catch {
            print("could not decode data")
        }
        
    }
    
    
    // MARK: - Table view data source
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = segue.destination as? UserDetailViewController, let indexPath = userTableView.indexPathForSelectedRow else {
            return
        }
        location.users = users[indexPath.row]
    }

}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
