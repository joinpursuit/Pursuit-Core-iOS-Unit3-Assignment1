//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var users = [User]() {
        didSet{
            tableView.reloadData()
        }
    }
    var userQuery = "" {
        didSet{
            users = UserInfo.getUsers(using: UserInfo.getData(from: "userinfo", with: "json")).filter{ (user: User) -> Bool in
                let fullName = user.name.first.lowercased() + " " + user.name.last.lowercased()
                
                if fullName.contains(userQuery.lowercased()){
                    return true
                } else {
                    return false
                }
            }
            users = users.sorted{$0.name.first.lowercased() < $1.name.first.lowercased()}
        }
    }
    // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
  }

    // MARK: Helper Methods
    private func setUp(){
        let filename = "userinfo"
        let ext = "json"
        users = UserInfo.getUsers(using: UserInfo.getData(from: filename, with: ext))
        users = users.sorted{$0.name.first.lowercased() < $1.name.first.lowercased()}
    }

}

// MARK: tableView DataSource Methods
extension UserInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let xCell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath)
        xCell.textLabel?.numberOfLines = 0
        xCell.textLabel?.text = users[indexPath.row].name.first.capitalized + " " + users[indexPath.row].name.last.capitalized
        xCell.detailTextLabel?.text = users[indexPath.row].location.city
        return xCell
    }
}

extension UserInfoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedUserInfoVC = newStoryboard.instantiateViewController(withIdentifier: "detailedUserInfoVC") as? DetailedUserInfoViewController else {
            fatalError("Could not obtain instance of View Controller as detailedUserInfoViewController")
        }
        detailedUserInfoVC.currentUser = users[indexPath.row]
        navigationController?.pushViewController(detailedUserInfoVC, animated: true)
    }
}

// MARK: SearchBar Delegate Methods
extension UserInfoViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            let filename = "userinfo"
            let ext = "json"
            users = UserInfo.getUsers(using: UserInfo.getData(from: filename, with: ext))
            users = users.sorted{$0.name.first.lowercased() < $1.name.first.lowercased()}
            return
        }
        userQuery = searchText
    }
}
