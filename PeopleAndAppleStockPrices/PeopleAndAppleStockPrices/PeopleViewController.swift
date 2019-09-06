//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    var peopleArr = [resultsInfo]() {
        didSet{
            peopleTableView.reloadData()
        }
    }
    
    @IBOutlet var userSearchBar: UISearchBar!
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        peopleTableView.dataSource = self
        userSearchBar.delegate = self
        peopleTableView.delegate = self
    }
    
    var userSearchedText: String? {
        didSet {
            self.peopleTableView.reloadData()
        }
    }
    
    var filteredPeople: [resultsInfo]  {
        guard let searchedText = userSearchedText else {
            return peopleArr
        }
        if searchedText == ""{
            return peopleArr
        }
        return peopleArr.filter({$0.name.first.lowercased().contains(searchedText.lowercased())})
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       userSearchedText = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
        self.peopleTableView.reloadData()
    }
    
    private func loadData() {
        PeopleAPIManager.shared.getPeople {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let peopleArrFromOnline):
                    self.peopleArr = peopleArrFromOnline
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let person = filteredPeople[indexPath.row]
        cell.textLabel?.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        cell.detailTextLabel?.text = person.location.state
        return cell
    }
}
extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyBoard = storyboard?.instantiateViewController(withIdentifier: "PeopleDetailViewController") as? PeopleDetailViewController {
            storyBoard.allPeople = peopleArr[indexPath.row]
            navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
}


