//
//  ContactsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    var contacts = [ContactDetails]()
//    {
//        didSet{
//            DispatchQueue.main.async {
//                self.contactsTableView.reloadData()
//            }
//        }
//    }
   
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        contactsTableView.dataSource = self
        contactsSearchBar.delegate = self
     
        
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource : "userinfo", ofType : "json"){
        let url = URL.init(fileURLWithPath: path)
        if let data = try? Data.init(contentsOf : url){
                do{
                    let newContacts = try JSONDecoder().decode(ContactDetails.Contacts.self, from: data)
                    contacts = newContacts.results
                }catch{
                    print(error)
                }
            }
        }
            
    }
}
extension ContactsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        let contactToSet = contacts[indexPath.row]
        cell.textLabel?.text = contactToSet.name.first + " " + contactToSet.name.last
        cell.detailTextLabel?.text = contactToSet.location.city
        
        return cell
        }
 }


extension ContactsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
   //     searchContacts(searchTerm: searchTerm)
        
        
      }
    }



//
//ContactAPICLient.searchContacts(searchTerm: searchTerm){(contacts, error) in
//    if let error = error{
//        print(error)
//if let contacts = contacts{
//self.contacts = contacts
//}
// }
//}
