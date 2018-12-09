//
//  ContactsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
  
  private var contacts = [ResultsToSet]()
  
  @IBOutlet weak var contactsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadContacts()
    dump(contacts)

    contactsTableView.dataSource = self
  }
  
  func loadContacts(){
    if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
      let contactsURL = URL.init(fileURLWithPath: path)
      if let data = try? Data.init(contentsOf: contactsURL){
        do{
          let contactToSet = try JSONDecoder().decode(User.self, from: data)
          
          contacts = contactToSet.results
       
        } catch {
          print(error)
        }
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = contactsTableView.indexPathForSelectedRow,
      let contactsDetailedVC = segue.destination as? ContactsDetailedViewController else {fatalError("Can't find segue info for contacts or index path")}
    
    let contactToSegue = contacts[indexPath.row]
    contactsDetailedVC.detailedContactInfo = contactToSegue
  }
  
}

extension ContactsViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
    
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
    let currentContact = contacts[indexPath.row]
    cell.textLabel?.text = currentContact.name.getFullName()
    cell.detailTextLabel?.text = currentContact.location.city
    
    return cell
  }
}

