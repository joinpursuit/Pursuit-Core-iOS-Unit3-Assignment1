//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liubov Kaper  on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var allStocksInfo = [[Stock]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self 
       
    }
    
    func loadData() {
//        let filename = "applestockinfo"
//        let ext  = "json"
//        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        allStocksInfo = Stock.stockSections()
    }
    
    func avgStock(for arr: [Stock]) -> Double {
       var sum = 0.0
       var avg = 0.0
        for stock in arr {
            sum += stock.open
        }
        avg = sum / Double(arr.count)
        return avg
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailStocVC = segue.destination as? DetailStockViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let stockInfo = allStocksInfo[indexPath.section][indexPath.row]
        detailStocVC.stockWhole = stockInfo
    }


}

extension StockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allStocksInfo[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let stock = allStocksInfo[indexPath.section][indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let newDate = allStocksInfo[section].first?.date
        var dateComponents = newDate?.components(separatedBy: "-")
        dateComponents?.removeLast()
        let dateJoined = dateComponents?.joined(separator: " ") ?? ""
       let averagrStock = avgStock(for: allStocksInfo[section])
        return "\(dateJoined): Average: $\(String(format: "%.2f", averagrStock))"
    }
    func numberOfSections(in tableView: UITableView) -> Int {


        return allStocksInfo.count
    }
}
