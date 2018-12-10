//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    @IBOutlet weak var contactsSeachBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [ContactInfo]()
    var sortedContacts = [ContactInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        dump(contacts)
        contactsTableView.dataSource = self
  }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    let contact = try JSONDecoder().decode(Contacts.self, from: data)
                    contacts = contact.results
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ContactsDetailViewController, let contactIndexPath = contactsTableView.indexPathForSelectedRow
        else { return }
        let personToSend = sortedContacts[contactIndexPath.row]
        destination.person = personToSend
    }
    
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        sortedContacts = contacts.sorted(by: {
            if $0.name.first == $1.name.first {
            return $0.name.last < $1.name.last
            } else {
                return $0.name.first < $1.name.first
            }})
        let contact = sortedContacts[indexPath.row]
        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        cell.detailTextLabel?.text = contact.location.state.capitalized
        return cell
    }
}
