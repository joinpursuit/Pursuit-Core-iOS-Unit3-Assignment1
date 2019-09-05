//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class userViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var userTableView: UITableView!


    @IBOutlet weak var userSearchBar: UISearchBar!
    
 
    
    var user = [ResultsWrapper]() {
        
        didSet {
            userTableView.reloadData()
            
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentUser = user[indexPath.row]
        let cell = userTableView.dequeueReusableCell(withIdentifier: "contactsCell")
        cell?.textLabel?.text = currentUser.getFullName()
        cell?.detailTextLabel?.text = currentUser.getLocation()
        return cell!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        self.userSearchBar.delegate = self
    }
    
    private func configureTableView() {
        userTableView.delegate = self
        userTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifer = segue.identifier else {fatalError("No indentifier in segue")}
        
        switch segueIdentifer {
            
        case "segToDescription":
            guard let destVC = segue.destination as? userDetailedViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = userTableView.indexPathForSelectedRow else {fatalError("No row selected")
            }
            let currentUser = user[selectedIndexPath.row]
            destVC.currentUser = currentUser
            
            
        default:
            fatalError("unexpected segue identifies")
            
        }
    }
    
    private func loadData () {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("user.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            let userinfoFromJSON = try ResultsWrapper.getUser(from: data)
            user = userinfoFromJSON
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
        
    }
    
    
}

extension userViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.userSearchBar = userSearchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
}

//MARK: -- Alphabetize names, make searchbar do search shit, add any missing detailVC labels
