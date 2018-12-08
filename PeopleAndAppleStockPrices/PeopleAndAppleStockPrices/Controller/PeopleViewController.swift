//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var people = [People]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    myTableView.dataSource = self
    searchPeople()
  }

    private func searchResult(completion: @escaping([People]?) -> Void){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
                do {
                    let searchData = try JSONDecoder().decode(People.searchData.self, from: data)
                    completion(searchData.results)
                } catch {
                    print(error)
                }
            }
        }
    }
    private func searchPeople(){
        searchResult{people in
            if let peopleResult = people{
                self.people = peopleResult
            }
        }
    }
}
extension PeopleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let user = people[indexPath.row]
        cell.textLabel?.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        cell.detailTextLabel?.text = user.location.city.capitalized
        return cell
    }
}
