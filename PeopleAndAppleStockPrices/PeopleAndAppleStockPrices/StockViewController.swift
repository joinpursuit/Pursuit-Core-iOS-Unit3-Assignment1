//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let filename = "applstockinfo"
    let ext = "json"
    
    var stockData = [StockData]() {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        stockData = StockData.getStockData(from: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondStockVC = segue.destination as? StockDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name in identity inspector")
        }
        
        let detail = stockData[indexPath.row]
        secondStockVC.someStock = detail
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard let detailPeopleVC = segue.destination as? DetailPeopleViewController, let indexPath = tableView.indexPathForSelectedRow else {
    //            fatalError("verify class name in identity inspector")
    //        }
    //        let contact = userContacts[indexPath.row]
    //        detailPeopleVC.contactsOfUser = contact
    //    }
    //}

}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let stock = stockData[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(stock.open)
        return cell
    }
}

//
//extension PeopleViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        userContacts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
//
//        let contact = userContacts[indexPath.row]
//        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
//        cell.detailTextLabel?.text = contact.location.city.capitalized
//        return cell
//    }
//}

