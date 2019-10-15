//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksTableViewController: UIViewController {
    
    var stocks = [StocksByMonthAndYear]()
    
    @IBOutlet weak var stocksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        stocks = Stock.getStocksSortedByMonthAndYear()
    }
}

extension StocksTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks[section].stocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stock = stocks[section]
        return "\(stock.month) \(stock.year). AVG: \(stock.getMonthAverage())"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks[indexPath.section].stocks[indexPath.row]
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = "\(stock.day) \(stock.month) \(stock.year)"
        cell.detailTextLabel?.text = "\(stock.uOpen)"
        return cell
    }
}
