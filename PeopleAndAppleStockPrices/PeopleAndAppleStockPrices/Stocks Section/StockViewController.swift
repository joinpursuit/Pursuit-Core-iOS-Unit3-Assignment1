//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    var stocks = [AppleStocks]()
    
    @IBOutlet weak var stocksTableView: UITableView!
    var sectionName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        stocks = StockInfoService.loadData()
        fillSectionName()
    }
    func stockBySection(section: Int) -> [AppleStocks] {
        return stocks.filter{$0.sectionName == sectionName[section]}
    }
    
    func fillSectionName() {
        for stock in stocks {
            if !sectionName.contains(stock.sectionName) {
                sectionName.append(stock.sectionName)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailStocksViewController,
            let selectedIndexPath = stocksTableView.indexPathForSelectedRow else {return}
        let stockToSend = stocks[selectedIndexPath.row]
        destination.stocksView = stockToSend
        let backButton = UIBarButtonItem()
        backButton.title = "Stocks"
        navigationItem.backBarButtonItem = backButton
    }
}

extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        let stockToSet = stocks[indexPath.row]
        cell.textLabel?.text = stockToSet.date
        cell.detailTextLabel?.text = String(format: "%.2f",stockToSet.open)


        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stockBySection(section: section).count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let thisSection = sectionName[section]
        return thisSection
    }
   
    
}

