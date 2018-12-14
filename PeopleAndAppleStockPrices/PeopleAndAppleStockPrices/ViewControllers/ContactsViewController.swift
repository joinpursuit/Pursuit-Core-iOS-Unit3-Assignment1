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
    {
        didSet{
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        }
    }
   
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = loadData()
        contactsTableView.dataSource = self
        contactsSearchBar.delegate = self
     
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? ContactDetailViewController,
            let selectedContactIndexPath = contactsTableView.indexPathForSelectedRow else {return}
        let contactToSet = contacts[selectedContactIndexPath.row]
        destination.contact = contactToSet
    }
    
    
    func loadData()->[ContactDetails] {
        var contacts = [ContactDetails]()
        if let path = Bundle.main.path(forResource : "userinfo", ofType : "json"){
        let url = URL.init(fileURLWithPath: path)
        if let data = try? Data.init(contentsOf : url){
                do{
                    let newContacts = try JSONDecoder().decode(ContactDetails.Contacts.self, from: data)
                    contacts = newContacts.results.sorted{$0.name.first < $1.name.first}
                }catch{
                    print(error)
                }
            }
        }
        return contacts
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
        if let url = URL.init(string : contactToSet.picture.thumbnail){
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data){
                    cell.imageView?.image = image
                }
            }catch{
                print(error)
            }
            
        }
        return cell
        }
 }


extension ContactsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            contacts = loadData()
            if searchTerm == ""{
                return
            } else {
                contacts = loadData().filter{$0.name.first.lowercased().contains(searchTerm.lowercased())}
            }
        }
    }
}

        


