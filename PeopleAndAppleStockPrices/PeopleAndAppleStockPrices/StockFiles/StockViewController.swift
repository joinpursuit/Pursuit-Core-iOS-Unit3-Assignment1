//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   var prices = [AppleStockPrices]()
   var sectionNames = [String]()
    
    func sortBySection(sectionNumber: Int) -> [AppleStockPrices] {
        return prices.filter({$0.sectionName == sectionNames[sectionNumber]})
    }
    
    func getSectionNames() {
        for i in prices {
            if !sectionNames.contains(i.sectionName) {
                sectionNames.append(i.sectionName)
            }
        }
    }
    
    @IBOutlet weak var stockTableOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortBySection(sectionNumber: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableOutlet.dequeueReusableCell(withIdentifier: "price")
        let sortedStocks = sortBySection(sectionNumber: indexPath.section)
        let currentStock = sortedStocks[indexPath.row]

        cell?.textLabel?.text = currentStock.label
        cell?.detailTextLabel?.text = "Opening Price: \(currentStock.open) USD"
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailVC = segue.destination as? StockDetailViewController else { fatalError() }
        stockDetailVC.price = prices[stockTableOutlet.indexPathForSelectedRow!.row]
    }
    
    private func LoadData() {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let stockDataFromJSON = try AppleStockPrices.getStockData(from: data)
            prices = stockDataFromJSON
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableOutlet.delegate = self
        stockTableOutlet.dataSource = self
        LoadData()
        getSectionNames()
 }

}
