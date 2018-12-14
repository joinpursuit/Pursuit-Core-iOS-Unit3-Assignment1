//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var chosenUsers = [User]() {
        didSet {
            userTableView.reloadData()
        }
    }
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userTableView.dataSource = self
        userSearchBar.delegate = self
        self.chosenUsers.sort(by: {($0.name.last, $0.name.first) < ($1.name.last, $1.name.first)})
      }
//    private func searchUsers(keyword: String) {
//
//    }
    
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
        if let imageUrl = userToSet.picture.thumbnail {
            if let image = ImageClient.getImage(StringURL: imageUrl) {
                cell.imageView?.image = image
            }
        }
        return cell
    }
}
extension UserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        

        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
        
        if searchText == "" {
            return self.chosenUsers.sort(by: {($0.name.last, $0.name.first) < ($1.name.last, $1.name.first)})

        } else {
            chosenUsers = chosenUsers.filter{ (user: User) -> Bool in
                let fullName = "\(user.name.first) \(user.name.last)".lowercased()
                //return alphabetical
                return fullName.contains(searchText.lowercased())
            }
        }
    }
}
