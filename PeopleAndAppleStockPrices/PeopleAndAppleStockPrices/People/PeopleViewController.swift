//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    var people = [ResultWrapper]() {
        didSet { // property observer
            peopleTableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        peopleTableView.dataSource = self
        peopleSearchBar.delegate = self
    
        super.viewDidLoad()
        people = loadData()
        
        // dump(people)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let destination = segue.destination as? PeopleDetailViewController,
        let indexPath = peopleTableView.indexPathForSelectedRow else { return }
        let peoples = people[indexPath.row]
        destination.peopleData = peoples
    }
    func loadData() -> [ResultWrapper]{
        var results = [ResultWrapper]()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let newPeople = try JSONDecoder().decode(People.self, from: data)
                    results = newPeople.results.sorted{$0.name.first < $1.name.first}
                } catch {
                    print(error)
                }
            }
        }
        return results
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        let peopleInfo = people[indexPath.row]
        cell.textLabel?.text = "\(peopleInfo.name.first) \(peopleInfo.name.last)".capitalized
        //if let stateName = peopleInfo.location.city {
        cell.detailTextLabel?.text = peopleInfo.location.city
        guard let imageUrl = URL.init(string: peopleInfo.picture.thumbnail) else
        { return UITableViewCell() }
        do {
            let data = try Data.init(contentsOf: (imageUrl))
            cell.imageView?.image = UIImage.init(data: data)
        } catch {
            print(error)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            return
        } else {
            people = loadData().filter{$0.name.first.lowercased().contains(searchText.lowercased())}
        }
    }
}
