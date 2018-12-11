//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var people = [User]()
    var searchActive : Bool = false
    var filtered:[User] = []

    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    override func viewDidLoad() {
    super.viewDidLoad()
        loadData()
        userTableView.dataSource = self
        userSearchBar.delegate = self

  }
    func loadData() {
        
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            
            let myUrl = URL.init(fileURLWithPath: path)
            
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let newPeople = try JSONDecoder().decode(Profile.self, from: data)
                    people = newPeople.results.sorted { $0.name.first < $1.name.first }
                } catch {
                    print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController,
            let selectedIndexPath = userTableView.indexPathForSelectedRow else {return}
        let personToSend = people[selectedIndexPath.row]
        destination.profileView = personToSend
    }
}




extension UserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let peopleToSet = people[indexPath.row]
        let namesToSet = peopleToSet.name
        let locationToSet = peopleToSet.location
        let fullNameSet = namesToSet.fullName

        DispatchQueue.global().async {
            do {
                guard let url = URL.init(string: peopleToSet.picture.large!) else {return}
                let peopleImageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageView!.image = UIImage.init(data: peopleImageData)
                }
            } catch {
                print(error)
            }
            
        }
    
        cell.textLabel?.text = fullNameSet
        cell.detailTextLabel?.text = locationToSet.city.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
//            let filteredFullName = filtered[indexPath.row]
//            if(searchActive){
//                cell.textLabel?.text = filteredFullName.name.first
//            } else {
//                cell.textLabel?.text = fullNameSet
//            }


}

extension UserViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    //
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = people.filter{$0.name.first.contains(searchText)}
        if filtered.count == 0{
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.userTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



