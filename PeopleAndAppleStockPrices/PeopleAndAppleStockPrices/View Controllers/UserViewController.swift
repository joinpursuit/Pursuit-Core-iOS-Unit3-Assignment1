//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate {
    
    //MARK: -- Properties
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchBar: UITableView!
    var userInfo = [User]() {
        didSet {
            userTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.dataSource = self
        userTableView.delegate = self
        loadData()
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
            userInfo = usersFromJSON
        } catch {
            print("could not decode data")
        }
        
    }
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = userInfo[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = "\(user.name.firstName.capitalized) \(user.name.lastName.capitalized)"
        cell.detailTextLabel?.text = user.location.state.capitalized
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = segue.destination as? UserDetailViewController, let indexPath = userTableView.indexPathForSelectedRow else {
            return
        }
        location.users = userInfo[indexPath.row]
    }

}
