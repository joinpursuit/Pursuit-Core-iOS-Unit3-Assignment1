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
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = allUsers[indexPath.row]
        let userCell = userListTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        //refactor to capitalize name in models
        userCell.textLabel?.text = "\(currentUser.name.firstName.capitalized) \(currentUser.name.lastName.capitalized)"
        userCell.detailTextLabel?.text = currentUser.location.state.capitalized
        
        return userCell
    }
    
    
}
