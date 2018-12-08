//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    var userInfo = [UserInfo]()
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        peopleTableView.dataSource = self
        loadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow, let contactVC = segue.destination as? ContactViewController else {fatalError("Index path, contactVC is nil")}
        let people = userInfo[indexPath.row]
        contactVC.people = people
    }
    func loadData() {
        if let path = Bundle.main.path(forResource:"userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
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
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let info = userInfo[indexPath.row]
        let fullName = "\(info.name.first) \(info.name.last)"
        let fullLocation = "\(info.location.city), \(info.location.state)"
        cell.textLabel?.text = fullName.capitalized
        cell.detailTextLabel?.text = fullLocation.capitalized
        return cell
    }
}
