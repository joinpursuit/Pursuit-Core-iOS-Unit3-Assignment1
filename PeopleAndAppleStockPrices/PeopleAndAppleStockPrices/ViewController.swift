//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var people = [resultWrapper]()
    var searching: Bool = false
    var searchResult = [resultWrapper](){
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    peopleTableView.dataSource = self
    peopleSearchBar.delegate = self
   
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailedViewController,
            let cellSelected = peopleTableView.indexPathForSelectedRow else {return}
        let peopleSelected = people[cellSelected.row]
        destination.people = peopleSelected
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json")
        {
          let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let person = try JSONDecoder().decode(PeopleData.self, from: data)
                    people = person.results.sorted(by: {$0.name.fullName < $1.name.fullName})
                } catch {
                    print(error)
                }
            }
        }
}
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        if searching{
            let peopleToSet = searchResult[indexPath.row]
            cell.textLabel?.text = peopleToSet.name.fullName
            cell.detailTextLabel?.text = peopleToSet.location.state.capitalized
            return cell
        } else {
        let peopleToSet = people[indexPath.row]
        cell.textLabel?.text = peopleToSet.name.fullName
        cell.detailTextLabel?.text = peopleToSet.location.state.capitalized
        return cell
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchResult.count
        } else {
        return people.count
    }
}
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchResult = people.filter{$0.name.fullName.lowercased().contains(searchText.lowercased())}
            peopleTableView.reloadData()
            if searchText == "" {
                searching = false
                peopleTableView.reloadData()
            }
    }
    }

