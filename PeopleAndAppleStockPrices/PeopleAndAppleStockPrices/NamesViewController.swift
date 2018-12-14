//
//  NamesViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    var people = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsSearchBar.delegate = self
        contactsTableView.dataSource = self
        people = loadData()
        title = "Contacts"
        
    }
    
    func loadData() -> [User] {
        var results = [User]()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    let newPeople = try JSONDecoder().decode(Profile.self, from: data)
                    self.people = newPeople.results.sorted{$0.name.first < $1.name.first}
                    results = people
                } catch {
                    print("the error is \(error)")
                }
            }
        }
        return results
    }

    func getImage(url: String) -> UIImage? {
        guard let imageURL = URL.init(string: url) else { return nil}
        guard let data = try? Data.init(contentsOf: imageURL) else {return nil}
        let image = UIImage.init(data: data)
        return image
    }
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    guard let indexPath = segue.destination as? DetailViewController,
//    let DetailViewController = crayonTableView.indexPathForSelectedRow else { return }
//    let crayon = crayons[DetailViewController.row]
//    indexPath.aCrayon = crayon
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NamesDetailViewController,
            let indexPath = contactsTableView.indexPathForSelectedRow else { return }
        let person = people[indexPath.row]
        destination.aPerson = person
    }
}

extension NamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let personToSet = people[indexPath.row]
        cell.textLabel?.text = "\(personToSet.name.first)" + " " + "\(personToSet.name.last)"
        cell.detailTextLabel?.text = personToSet.location.city
        cell.imageView?.image = getImage(url: personToSet.picture.thumbnail!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}

extension NamesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        people = loadData()
        if searchText == "" {
            return
        } else {
            people = loadData().filter{$0.name.first.lowercased().contains(searchText.lowercased())}
        }
    }
}
