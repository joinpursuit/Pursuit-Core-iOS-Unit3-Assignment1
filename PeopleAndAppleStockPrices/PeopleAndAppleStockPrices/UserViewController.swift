//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var people = [User]()
    
    @IBOutlet weak var userTableOutlet: UITableView!
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableOutlet.dequeueReusableCell(withIdentifier: "user")
        
        cell?.textLabel?.text = "\(people[indexPath.row].name.title.capitalized). \(people[indexPath.row].name.first.capitalized) \(people[indexPath.row].name.last.capitalized)"
        cell?.detailTextLabel?.text = "\(people[indexPath.row].location.street.capitalized) \(people[indexPath.row].location.city.capitalized), \(people[indexPath.row].location.state.capitalized) \(people[indexPath.row].location.postcode.capitalized)"
        
        return cell!
    }
    
    
    
    
    private func LoadData() {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let userDataFromJSON = try UserWrapper.getUserData(from: data)
            people = userDataFromJSON
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
    
    
    
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userTableOutlet.delegate = self
    userTableOutlet.dataSource = self
    searchOutlet.delegate = self
    LoadData()
  }


}

