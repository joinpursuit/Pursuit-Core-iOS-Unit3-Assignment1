//
//  UsersViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alexander George Legaspi on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    var users = [User]()
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    private func loadData() {
        guard let pathToJSON = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("Could not find JSON file")
        }
        let url = URL(fileURLWithPath: pathToJSON)
        
        do {
            let data = try Data(contentsOf: url)
            let usersFromJSON = User.getUsers(from: data)
            users = usersFromJSON
        } catch {
            fatalError("Count not get Users from Data!")
        }
        
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = "\(user.name.first) \(user.name.last)"
        cell.detailTextLabel?.text = user.location.city
        
        return cell
    }
    
    
}
