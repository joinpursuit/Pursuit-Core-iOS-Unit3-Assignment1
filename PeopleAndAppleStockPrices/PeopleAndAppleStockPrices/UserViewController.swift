//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    
    var userData = [UserInfo]() {
        didSet {
            userTableView.reloadData()
        }
    }
    
    
    
    var userSearchString: String? = nil{
        didSet{
            print(userSearchString)
            self.userTableView.reloadData()
        }
    }
    
    var userRequestedSearch: [UserInfo] {
        guard let searchedUser = userSearchString else {
            return userData
        }
        guard searchedUser != "" else{
            return userData
        }
        
        if let scopeTitles = userSearchBar.scopeButtonTitles {
            let currentScopeIndex = userSearchBar.selectedScopeButtonIndex
            
            switch scopeTitles[currentScopeIndex] {
            case "user name":
//                filtered all the name letters in the database to lowercased to be equal the letters in SongSearchString
                return userData.filter{$0.name.fullName.lowercased().contains(searchedUser.lowercased())}
            case "city name":
                return userData.filter{$0.location.city.lowercased().contains(searchedUser.lowercased())}
            default:
                return userData.filter{$0.name.fullName.contains(searchedUser.lowercased()) || $0.location.city.contains(searchedUser.lowercased())}
            }
        }
        return userData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        loadData()
        userSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else{
            fatalError("Unexpected Error: couldnt find json file")
        }
        let url = URL(fileURLWithPath: pathToJSONFile)
        do{
            let data = try Data(contentsOf: url)
            self.userData = try UserWrapper.getUserData(from: data)
        }catch{
            print(error)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier =  segue.identifier else{
            fatalError("Unexpected Error: No identifier in segue")
        }
        switch segueIdentifier {
        case "userMainToDetailSegue":
            guard let userDetailVC = segue.destination as? UserDetailTableViewController else{
                fatalError("Unexpected Error: No VC")
            }
            guard let selectedIndexPath =
                self.userTableView.indexPathForSelectedRow else{
                    fatalError("Unexpected Error:")
            }
            userDetailVC.userDetails = userRequestedSearch[selectedIndexPath.row]
        default:
            fatalError("Unexpected Error")
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userSearchString = searchBar.text
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRequestedSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userInfo = userRequestedSearch[indexPath.row]
        let userCell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
//        userCell.textLabel?.text = "hey mami"
        userCell.textLabel?.text = "\(userInfo.name.fullName)"
        userCell.detailTextLabel?.text = "\(userInfo.location.city.capitalized)"
        return userCell
    }
    
    

}
