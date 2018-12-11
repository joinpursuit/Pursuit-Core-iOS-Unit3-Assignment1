//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    var sortedPeople = [ResultsWrapper]()
    
    var peopleList = [ResultsWrapper]() {
        didSet {
            peopleTableView.reloadData()
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    peopleTableView.dataSource = self
    peopleSearchBar.delegate = self
    loadData()
  }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let people = try JSONDecoder().decode(People.self, from: data)
                    peopleList = people.results
                    
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow, let peopleDetailViewController = segue.destination as? PeopleDetailViewController else {return}
        let people = sortedPeople[indexPath.row]
        peopleDetailViewController.people = people
    }


}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        sortedPeople = peopleList.sorted(by: {$0.name.first < $1.name.first})
        let peopleToSet = sortedPeople[indexPath.row]
        
        let fullName = "\(peopleToSet.name.first.capitalized) \(peopleToSet.name.last.capitalized)"
        cell.textLabel?.text = fullName
        cell.detailTextLabel?.text = peopleToSet.location.state.capitalized
        return cell
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let people = try JSONDecoder().decode(People.self, from: data)
                    peopleList = people.results.filter {$0.name.first.contains(searchText.lowercased())} + people.results.filter {$0.name.last.contains(searchText.lowercased())}
                    if searchText.isEmpty {
                        peopleList = people.results
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
