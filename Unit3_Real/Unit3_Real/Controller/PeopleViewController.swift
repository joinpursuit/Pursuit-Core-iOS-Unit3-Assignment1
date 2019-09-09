//
//  ViewController.swift
//  Unit3_Real
//
//  Created by EricM on 9/2/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import Foundation

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var userTableViewOutlet: UITableView!
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    var human = [Person]()
    
    var searchString: String? = nil {
        didSet{
            self.userTableViewOutlet.reloadData()
        }
    }
    
    var peopleSearchReults: [Person]{
        guard let _ = searchString else{
            return human
        }
        guard searchString != "" else {
            return human
        }
        let results = human.filter{$0.name.first.lowercased().contains(searchString!.lowercased())}
        return results
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchOutlet.resignFirstResponder()
        searchString = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleSearchReults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableViewOutlet.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let humas = peopleSearchReults[indexPath.row]
        cell.textLabel?.text = "\(humas.name.title).\(humas.name.first) \(humas.name.last) "
        cell.detailTextLabel?.text = "\(humas.location)"
        return cell
    }
    
    private func loadData() {
        //pathToJSONFile is just the string for the name of the file
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("Could not find json file")
        }
        //url is the reference of the location of the json file
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let resultsFromJSON = PeopleWrapper.getPeople(from: data)
            human = resultsFromJSON.results
            
        } catch {
            fatalError("Could not decode")
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else { fatalError("No identifier in segue")
        }
        guard let peopleVC = segue.destination as? PeopleDetailViewController
            else { fatalError("Unexpected segue")}
        guard let selectedIndexPath = userTableViewOutlet.indexPathForSelectedRow
            else { fatalError("No row selected") }
        peopleVC.peopleInfo = human[selectedIndexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableViewOutlet.dataSource = self
        userTableViewOutlet.delegate = self
        searchOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
}

