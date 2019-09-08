//
//  PeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    // MARK: Properties
    var peopleModel = [Person]()
    var searchString: String? = nil {
        didSet {
            self.peopleTableView.reloadData()
        }
    }
    var personSearchResults: [Person] {
        get {
            guard let searchString = searchString else {
                return peopleModel
            }
            guard searchString != "" else {
                return peopleModel
            }
            return peopleModel.filter({$0.name.fullyNamed.contains(searchString)})
        }
    }

    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        searchBarOutlet.delegate = self
        loadData()
    }
    
    // MARK: Private Methods
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("Could not find JSON file")
        }
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
          let data = try Data(contentsOf: url)
            let peopleFromJSON = People.getUsers(from: data)
            peopleModel = peopleFromJSON.sorted(by: {$0.name.fullyNamed < $1.name.fullyNamed})
        } catch {
            fatalError()
        }
    }
    
    // MARK: Navigation Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailPeople" {
            guard let detailPeopleVC = segue.destination as? DetailPeopleViewController else {
                fatalError()
            }
            guard let selectedIndexPath = peopleTableView.indexPathForSelectedRow else {
                fatalError()
            }
            detailPeopleVC.person = personSearchResults[selectedIndexPath.row]
        }
    }
    
    
}


// MARK: Extensions

extension PeopleViewController: UITableViewDelegate {
    
}


extension PeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        cell.textLabel?.text = personSearchResults[indexPath.row].name.fullyNamed
        cell.detailTextLabel?.text = personSearchResults[indexPath.row].location.city
        return cell
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBarOutlet.text
    }
}
