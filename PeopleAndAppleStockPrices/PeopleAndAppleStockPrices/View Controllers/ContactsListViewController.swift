//
//  ContactsListViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController, UITableViewDataSource {
    
    //MARK: -- Properties
    var contacts = [Person]() {
        didSet {
            filteredContactsList = self.contacts
        }
    }
    
    var searchString = String() {
        didSet {
            if self.searchString == "" {
                filteredContactsList = contacts
            } else if self.searchString.count >= 1 {
                filteredContactsList = contacts.filter { String("\($0.name.first?.lowercased()) \($0.name.last?.lowercased())").contains(self.searchString) }
            } else {
                filteredContactsList = contacts
            }
        }
    }
    
    var filteredContactsList = [Person]()
    
    //MARK: -- IBOutlets
    @IBOutlet weak var contactsListTableView: UITableView!
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: -- DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = filteredContactsList[indexPath.row]
        let cell = contactsListTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = "\(person.name.first?.capitalized ?? "") \(person.name.last?.capitalized ?? "")"
        cell.detailTextLabel?.text = "\(person.location.street)\n\(person.location.city), \(person.location.state)"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
