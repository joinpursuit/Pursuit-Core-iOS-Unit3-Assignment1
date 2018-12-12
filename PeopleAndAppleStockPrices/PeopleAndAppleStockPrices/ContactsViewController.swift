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
        guard let destination = segue.destination as? ContactsDetailController,
            let selectedIndexPath = contactTableView.indexPathForSelectedRow else { return }
        let contactToSend = contacts[selectedIndexPath.row ]
        destination.contacts = contactToSend
        
    }
    var contacts = [ContactInfo](){
        didSet {
            contactTableView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = loadData()
        contactTableView.dataSource = self
        searchBar.delegate = self
        //dump(contacts)
    }
    
    func loadData() -> [ContactInfo] {
        var results = [ContactInfo]()

        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let contact = try JSONDecoder().decode(Contact.self, from: data)
                    results = contact.results.sorted{$0.name.fullName < $1.name.fullName}
                    
                } catch {
                    print(error)
                }
            }
        }
        return results
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
        cell.detailTextLabel?.text = contactToSet.location.state.capitalized
        return cell
    }
    
}


//  a function that invokes every time the user types on the Search Bar.
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        contacts = loadData()
        if searchText == ""{
            return
        } else {
            contacts = loadData().filter{$0.name.fullName.lowercased().contains(searchText.lowercased())}
        }
    }

}
