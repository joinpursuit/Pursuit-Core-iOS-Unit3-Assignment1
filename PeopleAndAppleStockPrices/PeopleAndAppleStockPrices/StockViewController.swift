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
    
    var stockData = [[StockData]]() {
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
        //stockData = StockData.getStockData(from: data)
        stockData = StockData.monthSections()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondStockVC = segue.destination as? StockDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name in identity inspector")
        }
        
        let detail = stockData[indexPath.section][indexPath.row]
        secondStockVC.someStock = detail
    }
    
    func findAverage(for array: [StockData]) -> Double {
             var sum = 0.0
             for stock in array {
                 sum += stock.open
             }
             let average = sum/Double(array.count)
             return average
         }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stockData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let stock = stockData[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(stock.open)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let oneOfDates = stockData[section].first?.date
        
        var updatedOneOfDates = oneOfDates?.components(separatedBy: "-")
        updatedOneOfDates?.removeLast()
        let sameDateJoined = updatedOneOfDates?.joined(separator: "-") ?? ""
        let averageForMonth = findAverage(for: stockData[section])
        return "\(sameDateJoined): Average: $\(String(format: "%.2f", averageForMonth))"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockData.count
    }
    
}


