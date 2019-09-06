//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var userSearchBar: UISearchBar!
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    var peopleArr = [resultsInfo]() {
        didSet{
            peopleTableView.reloadData()
        }
    }
    
    var userSearchedText: String? {
        didSet {
            self.peopleTableView.reloadData()
        }
    }
    
    var filteredPeople: [resultsInfo]  {
        guard let searchedText = userSearchedText else {
            return peopleArr
        }
    return peopleArr.filter({$0.name.first.lowercased().contains(searchedText.lowercased())})
     
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchedText = searchBar.text
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchedText = searchText
        
    }
        private func loadData() {
        PeopleAPIManager.shared.getPeople {(result) in
        DispatchQueue.main.async {
        switch result {
        case .failure(let error):
        print(error)
        case .success(let peopleArrFromOnline):
        self.peopleArr = peopleArrFromOnline
            }
        }
    }
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
        
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let person = filteredPeople[indexPath.row]
        cell.textLabel?.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        cell.detailTextLabel?.text = person.location.state
        return cell
        }
        
        override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        peopleTableView.dataSource = self
        userSearchBar.delegate = self
    //    peopleTableView.delegate = self
        
        }
        
    }

//
//    ImageHelper.shared.getImage(urlStr: thisBeer.imageURL) { (result) in
//        DispatchQueue.main.async {
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let imageFromOnline):
//                beerCell.beerImageVIew.image = imageFromOnline
//            }
//        }
//
//    }
//
//
//    return beerCell
//}
//
//
//
//}
//

