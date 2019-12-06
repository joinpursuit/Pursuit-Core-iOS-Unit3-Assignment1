//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userInfo = [UserDetails] () {
        didSet {
            tableView.reloadData()
        }
    }
    
    let filename = "userinfo"
    let ext  = "json"
    
    
    var searchQuary = "" {
        didSet {
            let data = Bundle.readRawJSONData(filename: filename, ext: ext)
            userInfo = User.getUserInfo(from: data).filter {$0.fullname.lowercased().contains(searchQuary.lowercased())}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
        print(userInfo.count)
    }
    
    func loadData() {
        
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        userInfo = User.getUserInfo(from: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailUserInfoVC = segue.destination as? DetailUserInfoViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let info = userInfo[indexPath.row]
        detailUserInfoVC.userInfoInfo = info
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let infoForUser = userInfo[indexPath.row]
        cell.textLabel?.text = "\(infoForUser.name.first.capitalized) \(infoForUser.name.last.capitalized)"
        cell.detailTextLabel?.text = infoForUser.location.city.capitalized
        return cell 
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuary = searchText
    }
}
