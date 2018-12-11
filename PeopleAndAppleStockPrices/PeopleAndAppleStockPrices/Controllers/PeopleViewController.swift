//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var people = [Person]() {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.dataSource = self
        peopleSearchBar.delegate = self
        
        people = PeopleAPIClient.getPeople()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow,
            let PeopleDetailVC = segue.destination as? PeopleDetailViewController else { return }
        
        let backItem = UIBarButtonItem()
        backItem.title = "People"
        navigationItem.backBarButtonItem = backItem
        
        let person = people[indexPath.row]
        PeopleDetailVC.person = person
    }
}


extension PeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let person = people[indexPath.row]
    
        cell.textLabel?.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        cell.detailTextLabel?.text = "\(person.location.city.capitalized), \(person.location.state.capitalized)"
        
        return cell
    }
    
}


extension PeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        people = PeopleAPIClient.getPeople()
        if searchText == "" {
            return
        } else {
            people = people.filter{ (person: Person) -> Bool in
                let fullName = "\(person.name.first) \(person.name.last)".lowercased()
                return fullName.prefix(searchText.count) == searchText.lowercased()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
