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
        cell.textLabel?.text = contactToSet.name.fullName
       cell.detailTextLabel?.text = contactToSet.location.state
//        } else {
//            cell.detailTextLabel?.text = "No Name"
//        }
//        if let imageUrl = articleToSet.urlToImage {
//            if let image = ImageClient.getImage(stringURL: imageUrl) {
//                cell.imageView?.image = image
//            }
//        }
        return cell
    }
    
}


//  a function that invokes every time the user types on the Search Bar. 
//func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    <#code#>
//}
