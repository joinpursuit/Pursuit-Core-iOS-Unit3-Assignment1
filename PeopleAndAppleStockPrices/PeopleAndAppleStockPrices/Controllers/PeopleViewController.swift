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
        peopleTableView.delegate = self
        peopleSearchBar.delegate = self
        
        loadData()
        dump(people)
    }
    
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


extension PeopleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //initiate
    }
    
}


extension PeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //update search as the user types
        //if it's a blank or space reload the whole thing
    }
    
}
