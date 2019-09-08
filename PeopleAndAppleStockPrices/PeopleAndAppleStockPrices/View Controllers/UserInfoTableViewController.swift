//
//  UserInfoTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserInfoTableViewController: UITableViewController {
    
    var userInfo = [User]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userInfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = userInfo[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = "\(user.name.firstName.capitalized) \(user.name.lastName.capitalized)"
        cell.detailTextLabel?.text = user.location.city.capitalized
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
