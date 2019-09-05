//
//  ContactsListViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
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
                filteredContactsList = contacts.filter { String(($0.name.first!.lowercased()) +
                     ($0.name.last!.lowercased()) ).contains(self.searchString) }
            } else {
                filteredContactsList = contacts
            }
        }
    }
    
    var filteredContactsList = [Person]() {
        didSet {
            contactsListTableView.reloadData()
        }
    }
    
    //MARK: -- IBOutlets
    @IBOutlet weak var contactsListTableView: UITableView!
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getContacts()
    }
    
    //MARK: -- DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = filteredContactsList[indexPath.row]
        let cell = contactsListTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = "\(person.name.first?.capitalized ?? "") \(person.name.last?.capitalized ?? "")"
        cell.detailTextLabel?.text = "\(person.location.street?.capitalized ?? "N/A"), \(person.location.city?.capitalized ?? "N/A"), \(person.location.state?.capitalized ?? "N/A")"
        return cell
    }
    
    //MARK: -- Custom Functions
    private func configureViewController() {
        contactsListTableView.dataSource = self
        contactsSearchBar.delegate = self
    }
    
    func getContacts() {
        guard let pathToJSON = Bundle.main.path(forResource: "userinfo", ofType: ".json") else { return }
        let url = URL(fileURLWithPath: pathToJSON)
        do {
            let data = try Data(contentsOf: url)
            let contactsFromData = try JSONDecoder().decode(Contacts.self, from: data)
            contacts = contactsFromData.people!.sorted(by: { (person1, person2) -> Bool in
                (person1.name.first! + person1.name.last!) < (person2.name.first! + person2.name.last!)
            })
        } catch let error {
            print(error)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case "contactInfo":
            guard let contactInfoVC = segue.destination as? ContactDetailsViewController else { return }
            guard let pathForSelectedContact = contactsListTableView.indexPathForSelectedRow else { return }
            contactInfoVC.person = filteredContactsList[pathForSelectedContact.row]
        default:
            return
        }
    }

}
