//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    var userInfo = [UserInfo]() {
        didSet {
            peopleTableView.reloadData()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    var sortedPeople = [UserInfo]()

    
    override func viewDidLoad() {
    super.viewDidLoad()
        peopleTableView.dataSource = self
        searchBar.delegate = self
        loadData()
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow, let cvc = segue.destination as? ContactViewController
            else{fatalError("indexPath CVC is nil")}
        let people = sortedPeople[indexPath.row]
        cvc.people = people
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
            do{
                userInfo = try JSONDecoder().decode(Results.self, from: data).results
            } catch {
                print(error)
            }
        }
        
    }

}
}
extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sortedPeople = userInfo.sorted(by: {$0.name.first < $1.name.first})
        
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let info = sortedPeople[indexPath.row]
        let fullName = "\(info.name.first) \(info.name.last)"
        let fullLocation = "\(info.location.city), \(info.location.state)"
        cell.textLabel?.text = fullName.capitalized
        cell.detailTextLabel?.text = fullLocation.capitalized
        
        return cell
    }
    
    
    
    
}
extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let path = Bundle.main.path(forResource:"userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    userInfo = try JSONDecoder().decode(Results.self, from: data).results
                    userInfo = userInfo.filter{$0.name.first.contains(searchText.lowercased())} + userInfo.filter{$0.name.last.contains(searchText.lowercased())}
                    if searchText.isEmpty {
                        userInfo = try JSONDecoder().decode(Results.self, from: data).results
                    }
                } catch {
                    print(error)
                }
            }
        }
        
    }
}


