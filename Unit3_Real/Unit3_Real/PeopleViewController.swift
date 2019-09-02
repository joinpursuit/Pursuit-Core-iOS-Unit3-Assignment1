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
    var human = [PeopleWrapper]() {
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
        cell.textLabel?.text = "\(humas.people[0].name.title) \(humas.people[0].name.first) \(humas.people[0].name.last) "
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableViewOutlet.dataSource = self
        userTableViewOutlet.delegate = self
        // Do any additional setup after loading the view.
    }


}

