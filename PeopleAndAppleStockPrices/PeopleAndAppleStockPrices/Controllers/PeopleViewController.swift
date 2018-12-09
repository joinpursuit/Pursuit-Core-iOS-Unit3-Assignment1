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
        
        loadData()
    }
    
    //get data from JSON and assigned to variable people
    func loadData() {
    
        guard let pathInString = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            print("path not found")
            return
        }
        let urlObject = URL.init(fileURLWithPath: pathInString)
        
        if let data = try? Data.init(contentsOf: urlObject) {
            do {
                let peopleSearchData = try JSONDecoder().decode(Person.searchData.self, from: data)
                people = peopleSearchData.results
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow,
            let PeopleDetailVC = segue.destination as? PeopleDetailViewController else { return }
        
        //change Navigation BackButton Text
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
        loadData()
        
        if searchText == "" {
            return
        } else {
            people = people.filter{ (person: Person) -> Bool in
                let fullName = "\(person.name.first) \(person.name.last)".lowercased()
                print("\(fullName.prefix(searchText.count)) == \(searchText.lowercased())")
                
                return fullName.prefix(searchText.count) == searchText.lowercased()
            }
        }
    }
    
    
}
