//
//  PeopleController.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleController: UIViewController {

    var peopleInfo = [PeopleInfo]() {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    @IBOutlet weak var peopleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.dataSource = self
        loadData()

    }
    
    private func loadData() {
        
        
        guard let pathToJSONfile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
        return
        }
        let url = URL(fileURLWithPath: pathToJSONfile)
        do {
            let data = try Data (contentsOf: url)
            peopleInfo = try UserInfoData.getUserInfoData(data: data)
        }
        catch {
            print (error)
            
        }




    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = peopleTableView.indexPathForSelectedRow,
            let destination = segue.destination as? DetailPeopleController else { return }
        
        var personToSendOver = peopleInfo[indexPath.row]
    destination.person = personToSendOver
        
    }



}
extension PeopleController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        var personInfo = peopleInfo[indexPath.row]
        cell.textLabel?.text = "\(personInfo.name.first.capitalized) \(personInfo.name.last.capitalized)"
        cell.detailTextLabel?.text = personInfo.location.state.capitalized
        return cell
    
    
    }
}
extension PeopleController: UITableViewDelegate {

    
    
}
