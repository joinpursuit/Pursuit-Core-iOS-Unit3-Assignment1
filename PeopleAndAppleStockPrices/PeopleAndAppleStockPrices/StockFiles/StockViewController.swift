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
    
    @IBOutlet weak var stockTableOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableOutlet.dequeueReusableCell(withIdentifier: "price")
        cell?.textLabel?.text = prices[indexPath.row].label
        cell?.detailTextLabel?.text = String(prices[indexPath.row].open)
        return cell!
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
 }

}
