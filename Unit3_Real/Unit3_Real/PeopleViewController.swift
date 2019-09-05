//
//  ViewController.swift
//  Unit3_Real
//
//  Created by EricM on 9/2/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userTableViewOutlet: UITableView!
    var human = [Person]() {
        didSet {
            userTableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return human.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableViewOutlet.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let humas = human[indexPath.row]
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
        loadData()
        // Do any additional setup after loading the view.
    }


}

