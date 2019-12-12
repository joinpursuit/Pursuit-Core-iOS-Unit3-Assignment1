//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var filteredUsers: [User] {
        users.sorted { $0.name.first < $1.name.last }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureView()
    }
    
    private func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("userinfo.json file not found")
        }
        let internalURL = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: internalURL)
            let usersFromJSON = try User.getUsers(from: data)
            users = usersFromJSON.sorted{ $0.name.first < $1.name.first }
        } catch {
            fatalError("An error occurred decoding: \(error)")
        }
    }
    
    
}

extension UserTableViewController: UITableViewDelegate {}
extension UserTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name.full
        cell.detailTextLabel?.text = users[indexPath.row].location.city
        return cell
    }
}

extension UserTableViewController: UISearchBarDelegate {}
