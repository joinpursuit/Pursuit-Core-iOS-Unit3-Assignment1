//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    

    var sortedPeople = [Person]() {
        
        didSet {
            peopleTableView.reloadData()
        }
    }
    var searchResult = [Person]() {
        
        didSet {
            peopleTableView.reloadData()
        }
    }
    var isBeingSearched = false
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var peopleTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Contacts"
        loadData()
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        mySearchBar.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myContactIndexPath = peopleTableView.indexPathForSelectedRow, let contactDetails = segue.destination as? PeopleDetailViewController else {return}
        let individual = sortedPeople[myContactIndexPath.row]
        contactDetails.presentPerson = individual
        
    }
    
    func loadData(){
        if let pathway = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: pathway)
            if let data = try? Data.init(contentsOf: myUrl){
                
                do{
                    let dicts = try JSONDecoder().decode(UserInformation.self, from: data)
                    sortedPeople = dicts.results.sorted(by: {$0.name.fullName < $1.name.fullName})
                   
                } catch {
                    print(error)
                }
            }
            
        }
    }
    
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        
        let personToSet = isBeingSearched ? searchResult[indexPath.row]: sortedPeople[indexPath.row]
     
        cell.textLabel?.text = personToSet.name.fullName
        cell.detailTextLabel?.text = personToSet.location.city.capitalized
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isBeingSearched ? searchResult.count : sortedPeople.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
extension ContactViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isBeingSearched = true
         searchBar.resignFirstResponder()

        searchResult = sortedPeople.filter{$0.name.fullName.lowercased().contains(searchText.lowercased())}
        peopleTableView.reloadData()
        if searchBar.text == "" {
           
            isBeingSearched = false
            peopleTableView.reloadData()
        }
        
    }
  
}

