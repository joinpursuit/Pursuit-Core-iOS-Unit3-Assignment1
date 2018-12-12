//
//  ContactsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
  
  
  @IBOutlet weak var contactsSearchBar: UISearchBar!
  
  @IBOutlet weak var contactsTableView: UITableView!
  
  
  private var contacts = [ResultsToSet]() {
    didSet{
      contactsTableView.reloadData()
    }
  }
  
  
  private var defaultContacts = [ResultsToSet]()
  
  var searchContact: String?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Users"
    loadContacts()
    dump(contacts)
    
    contactsTableView.dataSource = self
    contactsSearchBar.delegate = self
    
  }
  
  func loadContacts(){
    if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
      let contactsURL = URL.init(fileURLWithPath: path)
      if let data = try? Data.init(contentsOf: contactsURL){
        do{
          let contactToSet = try JSONDecoder().decode(User.self, from: data)
          
          contacts = contactToSet.results.sorted{$0.name.fullName < $1.name.fullName}
          
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
    cell.textLabel?.text = currentContact.name.fullName
    cell.detailTextLabel?.text = currentContact.location.city
    
    return cell
  }
}

extension ContactsViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    searchBar.resignFirstResponder()

    
    guard let searchText = searchBar.text else { return }
    
    guard !searchText.isEmpty else {return}
    
    contacts = contacts.filter{$0.name.fullName.capitalized.contains(searchText)}
    
    contactsTableView.reloadData()
    
    
  }
}

//oh thats just for your method
//
//  my method doesnt have another variable
//okay so search bar must change your original contacts everytime for it to reload data
//and for it to even work for cellforrow and number of rows in section
//so that means you need to change value in the search bar
//and you can filter the value of the contact there with searchtext
//doing my best not to expose answer completely...
//should i write simple steps pointing arrows for search bar to do things
//Input String in search bar - > search bar takes entire contact information - > search bar filters the contact information - > contact information changed due to filter - > reloads data
