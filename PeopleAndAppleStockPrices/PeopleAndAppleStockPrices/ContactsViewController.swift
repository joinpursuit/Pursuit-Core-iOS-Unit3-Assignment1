//
//  ContactsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [ContactInfo](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
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
        guard let destination = segue.destination as? ContactsDetailViewController, let contactIndexPath = tableView.indexPathForSelectedRow
            else { return }
        let selectedContact = contacts[contactIndexPath.row]
        destination.chosenContact = selectedContact
    }
    
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
        cell.detailTextLabel?.text = contact.location.state
        return cell
    }
}

extension ContactsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
        if searchText.isEmpty {
            return
        } else {
//            contacts = contacts.filter { $0.name.first.lowercased().contains(searchText.lowercased())}
            contacts = contacts.filter {$0.name.fullname.lowercased().contains(searchText.lowercased())}
            }
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if searchBar.text == "" {
            loadData()
        }
    }
}
