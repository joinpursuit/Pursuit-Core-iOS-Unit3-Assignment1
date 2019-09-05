//
//  ViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class RandomUserViewController:UIViewController {
    @IBOutlet weak var randomUserTableView: UITableView!
    
    @IBOutlet weak var seachingBar: UISearchBar!
    var rgbColor = RGBValue()
    var randomUser = [Results]() {
        didSet {
            DispatchQueue.main.async {
               
                self.randomUserTableView.reloadData()
                
        }
        }
    }
    var searchBarText: String? = nil {
        didSet {
            self.randomUserTableView.reloadData()
        }
    }
    var searchResults: [Results] {
        get {
            guard let searchString = searchBarText else {
                return randomUser
            }
            guard searchString != "" else {
                return randomUser
            }
            if let scopeVariable = seachingBar.scopeButtonTitles {
                
                let currentscopeIndex = seachingBar.selectedScopeButtonIndex
                switch scopeVariable[currentscopeIndex] {
                case "Names":
                    return randomUser.filter {$0.name.getName().lowercased().replacingOccurrences(of: " ", with: "").contains(searchString.lowercased().replacingOccurrences(of: " ", with: ""))}
                case "City":
                    return randomUser.filter {$0.location.capitalizeCity().lowercased().replacingOccurrences(of: " ", with: "").contains(searchString.lowercased().replacingOccurrences(of: " ", with: ""))}
                default:
                    return randomUser
                }

            }
            return randomUser

    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getData()

    }
  private func getData() {
    UserAPIClient.shared.fetchData { (results) in
        switch results {
        case .success(let user):
            self.randomUser = user.results
        case .failure(let failure):
            print("could not retrieve Data \(failure)")
        }
    }
    }
}

extension RandomUserViewController: UITableViewDelegate{}
extension RandomUserViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchBar.text
self.navigationItem.title = showResults.showResults(int: searchResults.count)

    }
    
}

extension RandomUserViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = randomUserTableView.dequeueReusableCell(withIdentifier: "randomUser")
        cell?.textLabel?.text = searchResults[indexPath.row].name.getName()
        cell?.detailTextLabel?.text = searchResults[indexPath.row].location.capitalizeCity()
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seachingBar.resignFirstResponder()

        if let storyBoard = storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerOne") as? DetailViewControllerOne {
            
            storyBoard.passingInfo = searchResults[indexPath.row]
            
            colorGenerator()
   storyBoard.randomColor = navigationController?.navigationBar.backgroundColor
           

            navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
    
    func setUp() {
        randomUserTableView.dataSource = self
        randomUserTableView.delegate = self
        seachingBar.delegate = self
        self.navigationItem.title = "Contacts"
        colorGenerator()
    }
    func colorGenerator(){
        rgbColor = RGBValue()
        self.navigationController?.navigationBar.backgroundColor = rgbColor.createRGBColor()
        
    }
}

