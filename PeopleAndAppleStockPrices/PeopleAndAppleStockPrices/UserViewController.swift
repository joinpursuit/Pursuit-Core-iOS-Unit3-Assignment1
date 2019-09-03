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
        cell?.textLabel?.text = User.formattedName(index: indexPath.row, userArray: people)
        cell?.detailTextLabel?.text = User.formattedAddress(index: indexPath.row, userArray: people)
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDetailVC = segue.destination as? UserDetailViewController else { fatalError() }
        userDetailVC.person = people[userTableOutlet.indexPathForSelectedRow!.row]
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

