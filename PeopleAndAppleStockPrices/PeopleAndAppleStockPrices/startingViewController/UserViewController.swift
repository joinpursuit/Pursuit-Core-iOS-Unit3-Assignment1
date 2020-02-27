//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Albert Oliveira on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpDelegates()
    }

      //MARK: - Variables
    @IBOutlet weak var userSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var user = [User](){
        didSet {
            tableView.reloadData()
        }
    }
    var userSearchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredPersonArr: [User]  {
        guard let userSearchTerm = userSearchTerm else {
            return user
        }
        guard userSearchTerm != "" else {
            return user
        }
        return user.filter({
           $0.name.first.lowercased().contains(userSearchTerm.lowercased())
            })
    }



 //MARK: - Controller Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jokeDetailVC = segue.destination as? UserDetailViewController else {
            fatalError("Unexpected segue")
        }
        guard let selectedIndexPath = tableView.indexPathForSelectedRow
            else { fatalError("No row selected") }
            jokeDetailVC.userInfo = filteredPersonArr[selectedIndexPath.row]
    }
    
    private func loadData() {
        FetchUserData.manager.getUsers{ (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let userData):
                self.user = userData
            }
        }
    }
    private func setUpDelegates(){
    tableView.delegate = self
    tableView.dataSource = self
    userSearch.delegate = self


    }
 
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPersonArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userTable")
        cell?.textLabel?.text = filteredPersonArr[indexPath.row].name.FullName()
        cell?.detailTextLabel?.text = user[indexPath.row].location.city
        return cell!
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
    }
}

