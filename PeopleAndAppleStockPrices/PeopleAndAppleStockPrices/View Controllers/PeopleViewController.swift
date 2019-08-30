//
//  PeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var contacts = [Contact]() {
        didSet {
            contactsTableView.reloadData()
        }
    }
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }
    

    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError("Could not find path")}
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let contactsFromJSON = Results.getContacts(from: data)
            contacts = contactsFromJSON
        } catch let loadDataError {
            fatalError("Error: \(loadDataError)")
        }
    }

}

extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        let oneContact = contacts[indexPath.row]
        cell.textLabel?.text = "\(oneContact.name.first) \(oneContact.name.last)"
        cell.detailTextLabel?.text = oneContact.location.city
        return cell
    }
    
    
}
