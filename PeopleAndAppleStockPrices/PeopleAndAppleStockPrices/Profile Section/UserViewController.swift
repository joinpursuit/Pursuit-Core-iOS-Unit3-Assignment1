//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var people = [User]() {
        didSet {
            userTableView.reloadData()
        }
    }

    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    override func viewDidLoad() {
    super.viewDidLoad()
        people = UserInfoService.loadData()
        userTableView.dataSource = self
        userSearchBar.delegate = self

  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController,
            let selectedIndexPath = userTableView.indexPathForSelectedRow else {return}
        let personToSend = people[selectedIndexPath.row]
        destination.profileView = personToSend
        let backButton = UIBarButtonItem()
        backButton.title = "Profile"
        navigationItem.backBarButtonItem = backButton
    }
}

extension UserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let peopleToSet = people[indexPath.row]
        let namesToSet = peopleToSet.name
        let locationToSet = peopleToSet.location
        let fullNameSet = namesToSet.fullName
    
        cell.textLabel?.text = fullNameSet
        cell.detailTextLabel?.text = locationToSet.city.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}

extension UserViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        people = UserInfoService.loadData()
        if searchText == "" {
            return
        } else {
            people = UserInfoService.loadData().filter{$0.name.first.lowercased().contains(searchText.lowercased()) || $0.name.last.lowercased().contains(searchText.lowercased())}
        }
    }
}
