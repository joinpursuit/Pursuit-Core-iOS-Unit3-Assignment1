//
//  ContacttsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contactsIndexPath = contactTableView.indexPathForSelectedRow,
            let contactDetails = segue.destination as? ContactsDetailController else { return }
        let contactPeople = contacts[contactsIndexPath.row]
        contactDetails.contacts = [contactPeople]
    }
    var contacts = [ContactInfo](){
        didSet {
            DispatchQueue.main.async {
                self.contactTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        contactTableView.dataSource = self
        searchBar.delegate = self
        //dump(contacts)
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let contact = try JSONDecoder().decode(Contact.self, from: data)
                    contacts = contact.results.sorted{$0.name.fullName < $1.name.fullName}
                    
                } catch {
                    print(error)
                }
            }
        }
    }
}


extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contactToSet = contacts[indexPath.row]
        guard let image = URL.init(string: contactToSet.picture.thumbnail) else { return UITableViewCell() }
        do {
             let data = try Data.init(contentsOf: image)
                cell.imageView?.image = UIImage.init(data: data)
            
        } catch {
            print(error)
        }
        cell.textLabel?.text = contactToSet.name.fullName
        cell.detailTextLabel?.text = contactToSet.location.state
        return cell
    }
    
}


//  a function that invokes every time the user types on the Search Bar.


extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        guard let searchText = searchBar.text else { return }
        contacts = contacts.filter {$0.name.fullName.contains(searchText)}
       // searchBar.resignFirstResponder()

        }
    }

