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
        people = loadData()
        userTableView.dataSource = self
        userSearchBar.delegate = self

  }
    func loadData() -> [User] {
        
        var results = [User]()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            
            let myUrl = URL.init(fileURLWithPath: path)
            
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let newPeople = try JSONDecoder().decode(Profile.self, from: data)
                    results = newPeople.results.sorted { $0.name.first < $1.name.first }
                } catch {
                    print(error)
                }
            }
        }
        return results
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController,
            let selectedIndexPath = userTableView.indexPathForSelectedRow else {return}
        let personToSend = people[selectedIndexPath.row]
        destination.profileView = personToSend
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
        people = loadData()
        if searchText == "" {
            return
        } else {
            people = loadData().filter{$0.name.first.lowercased().contains(searchText.lowercased())}
        }
    }
}
