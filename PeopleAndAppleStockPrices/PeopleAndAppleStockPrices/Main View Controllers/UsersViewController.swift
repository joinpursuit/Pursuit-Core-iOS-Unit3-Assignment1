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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.rowHeight = 80
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        cell.textLabel?.text = user.getFullName()
        cell.detailTextLabel?.text = user.getFullAddress()
        return cell
    }
    
    
}

extension UsersViewController: UITableViewDelegate {}
