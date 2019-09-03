//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//
import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var userData: UserInfo!
    
    
    var searchString: String? = nil {
        didSet {
            self.userTableView.reloadData()
        }
    }
    var searchResults: [User] {
        get {
            guard let searchString = searchString else {
                return userData.sortMe(users: userData.results)
                
            }
            guard searchString != "" else {
                return userData.sortMe(users: userData.results)
            }
            let currentIndex = userSearchBar.selectedScopeButtonIndex
            let filtered = userData.results.filter{$0.name.fullName().contains(searchString)}
            return userData.sortMe(users: filtered)
            
            
            }
        }
    
    
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    

    @IBOutlet weak var userTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = searchResults[indexPath.row]
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = user.name.fullName()
        cell.detailTextLabel?.text = user.location.city.capitalizingFirstLetter()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier in segue")
        }
        switch segueIdentifier {
        case "userSegue":
            guard let detailVC = segue.destination as? UserDetailVC
                else {
                    fatalError("Unexpected segue")}
            guard let selectedIndexPath = userTableView.indexPathForSelectedRow else {
                fatalError("No row selected")
            }
            detailVC.user = searchResults[selectedIndexPath.row]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    
    

    private func loadData() {
        //pathToJSONFile is just the string for the name of the file
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("Could not find bundle")
        }
        print(pathToJSONFile)
        //url is the reference of the location of the json file
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let resultsFromJSON = UserInfo.getInfo(from: data)
            userData = resultsFromJSON
        } catch {
            fatalError("Could not decode")
        }
    }

    override func viewDidLoad() {
        userTableView.delegate = self
        userTableView.dataSource = self
        loadData()
        userSearchBar.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}



extension UserViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = userSearchBar.text
    }
    
    }
    
    
    
    




