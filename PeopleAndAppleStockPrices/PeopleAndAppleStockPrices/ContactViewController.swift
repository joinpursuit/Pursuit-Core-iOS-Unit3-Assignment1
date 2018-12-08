//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
 var person = [resultsWrapper]()
    
    @IBOutlet weak var peopleTableView: UITableView!
    override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        title = "Contacts"
    // Do any additional setup after loading the view, typically from a nib.
  }
    func loadData(){
        if let pathway = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: pathway)
            if let data = try? Data.init(contentsOf: myUrl){
                
                do{
                    let dicts = try JSONDecoder().decode(UserInformation.self, from: data)
                 person = dicts.results
             
                } catch {
                    print(error)
                }
            }
            
        }
    }
    
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let personToSet = person[indexPath.row]
      cell.textLabel?.text = "\(personToSet.name.last.capitalized)  \(personToSet.name.first.capitalized)"
        cell.detailTextLabel?.text = personToSet.location.city
return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return person.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

