//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var userListTableView: UITableView!
    
    var allUsers = [User]() {
        didSet {
            userListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadUserData()
    }
    
    private func configureTableView() {
        userListTableView.dataSource = self
        userListTableView.delegate = self
    }
    
    private func loadUserData() {
        let userData = DataFetchingService.getUserDataFromJSON()
        allUsers = UserWrapper.getAllUsers(from: userData)!.results
    }

}

extension UserListViewController: UITableViewDelegate {}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = allUsers[indexPath.row]
        let userCell = userListTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        userCell.textLabel?.text = "\(currentUser.name.firstName.capitalized) \(currentUser.name.lastName.capitalized)"
        userCell.detailTextLabel?.text = currentUser.location.state.capitalized
        
        return userCell
    }
    
    
}
