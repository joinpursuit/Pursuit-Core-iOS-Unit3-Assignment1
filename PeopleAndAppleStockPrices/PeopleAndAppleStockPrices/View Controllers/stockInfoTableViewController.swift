//
//  stockInfoTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stockInfoTableViewController: UITableViewController {

    //MARK: -- Properties
    
    var stocks = [StocksMonthAndYear]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: -- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        stocks = StockInfo.stocksSorted()
    }
    
    

    // MARK: -- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks[section].stocks.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stock = stocks[section]
        return "\(stock.month) \(stock.year). AVG: $\(String(format:"%.2f", stock.getMonthAverage()))"
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks[indexPath.section].stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = "\(stock.month) \(stock.day), \(stock.year)"
        cell.detailTextLabel?.text = "$\(stock.open.description)"
        return cell
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = segue.destination as? StocksDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
        
        location.stock = stocks[indexPath.section].stocks[indexPath.row]
    }
    
}

