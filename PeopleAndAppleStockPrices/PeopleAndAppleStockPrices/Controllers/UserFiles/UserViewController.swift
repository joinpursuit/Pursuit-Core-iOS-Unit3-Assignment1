//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var chosenUsers = [User]()
    @IBOutlet weak var userTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userTableView.dataSource = self

      }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = userTableView.indexPathForSelectedRow,
            let userDetailViewController = segue.destination as? UserDetailViewController else {return}
        let chosenUser = chosenUsers[indexPath.row]
        userDetailViewController.userSelected = chosenUser
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    chosenUsers = user.results
//                    dump(chosenUsers)

                } catch {
                    print(error)
                }
            }
        }
    }
}
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let userToSet = chosenUsers[indexPath.row]
        cell.textLabel?.text = userToSet.name.first.capitalized + " " + userToSet.name.last.capitalized
        cell.detailTextLabel?.text = userToSet.location.city.capitalized
        return cell
    }
}
