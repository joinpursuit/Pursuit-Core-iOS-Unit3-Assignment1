//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    var people = [People]() 
    
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        peopleTableView.dataSource = self
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json")
        {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.people = try JSONDecoder().decode([People].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
       let peopleInfo = people[indexPath.row]
        cell.textLabel?.text = peopleInfo.first
        cell.detailTextLabel?.text = peopleInfo.state
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}
