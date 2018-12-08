//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    private var sortedPeople = [People]()
    var people = [People]() {
        didSet {
            myTableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    myTableView.dataSource = self
    peopleSearchBar.delegate = self
    searchResult{people in
        if let peopleResult = people{
            self.people = peopleResult
        }
    }
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = myTableView.indexPathForSelectedRow,
            let peopleDetailViewController = segue.destination as? PeopleDetailViewController else {return}
        let user = sortedPeople[indexPath.row]//REASON FOR ERROR
        peopleDetailViewController.user = user
    }
    
    private func searchResult(completion: @escaping([People]?) -> Void){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
                do {
                    let searchData = try JSONDecoder().decode(People.searchData.self, from: data)
                    completion(searchData.results)
                } catch {
                    print(error)
                }
            }
        }
    }
    private func searchPeople(keyword: String){
        searchResult{people in
            if let peopleResult = people{
                self.people = peopleResult
                self.people = peopleResult.filter{$0.name.first.lowercased().contains(keyword.lowercased())}
            }
        }
    }
}
extension PeopleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        sortedPeople = people.sorted(by: {$0.name.first < $1.name.first})
        let user = sortedPeople[indexPath.row]
        cell.textLabel?.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        cell.detailTextLabel?.text = user.location.city.capitalized
        return cell
    }
}

extension PeopleViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchPeople(keyword: searchText)
        if searchText.text = "" {}
    }
}
