//
//  StockListViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController {

    @IBOutlet weak var stockListTableView: UITableView!
    
    var allStocks = [Stock]() {
        didSet {
            stockListTableView.reloadData()
        }
    }
    
    var headerNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadStockData()
        addSectionNames()
    }
    
    private func configureTableView() {
        stockListTableView.dataSource = self
        stockListTableView.delegate = self
    }
    
    private func loadStockData() {
        let stockData = DataAPIClient.getStockDataFromJSON()
        // TODO: Refactor later to not force unwrap?
        allStocks = Stock.getAllStocks(from: stockData)!
    }
    
    // TODO: Refactor to use error codes instead of fatalerror
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = stockListTableView.indexPathForSelectedRow else { fatalError("No cell was selected") }
        guard segue.identifier == "stockCellToDetailSegue" else { fatalError("Unidentified segue") }
        guard let stockDetailsVC = segue.destination as? StockDetailViewController else { fatalError("No destination View Controller") }
        
        //TODO: Refactor two lines of code below as a func to be reused throughout code
        let stocksForSection = allStocks.filter { $0.dateForHeader == headerNames[selectedIndex.section] }
        let currentStock = stocksForSection[selectedIndex.row]
        
        stockDetailsVC.stock = currentStock
    }
    
}

extension StockListViewController: UITableViewDelegate {
    
    private func addSectionNames() {
        for stock in allStocks where !headerNames.contains(stock.dateForHeader) {
            headerNames.append(stock.dateForHeader)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stocksForSection = allStocks.filter { $0.dateForHeader == headerNames[section] }
        let averageStockPrice = Stock.getAverageForMonth(stockInSection: stocksForSection)
        return "\(headerNames[section]) -- Average Open Price: $\(averageStockPrice)"
    }
}

extension StockListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stocksForSection = allStocks.filter { $0.dateForHeader == headerNames[section] }
        return stocksForSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockCell = stockListTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stocksForSection = allStocks.filter { $0.dateForHeader == headerNames[indexPath.section] }
        let currentStock = stocksForSection[indexPath.row]
        
        stockCell.textLabel?.text = currentStock.date
        stockCell.detailTextLabel?.text = "$\(currentStock.open)"
        
        if currentStock.didStockProfit(open: currentStock.open, close: currentStock.close) {
            stockCell.backgroundColor = UIColor.green
        } else {
            stockCell.backgroundColor = UIColor.red
        }
        
        return stockCell
    }
    
    
}
