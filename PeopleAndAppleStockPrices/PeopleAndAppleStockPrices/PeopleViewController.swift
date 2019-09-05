//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    var peopleArr = [resultsInfo]() {
        didSet{
            peopleTableView.reloadData()
            
        }
    }
    
    var filteredPeople: [resultsInfo] {
        get {
            guard searchedText != "" else { return peopleArr }
            print("searched text")
            return peopleArr.filter{$0.name.first.contains(searchedText)}
        }
    }
    
    var searchedText: String = "" {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // searchedText = searchText
        self.searchedText = searchText
 

        
        //goal is to change characters in search bar as user inputs letters.
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
       // return peopleArr.count
        return filteredPeople.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        //let person = peopleArr[indexPath.row]
        let person = filteredPeople[indexPath.row]
        cell.textLabel?.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        cell.detailTextLabel?.text = person.location.state
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        peopleTableView.dataSource = self
        searchBar.delegate = self
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
