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
        // refactor later to not force unwrap?
        allStocks = Stock.getAllStocks(from: stockData)!
    }
    
}

extension StockListViewController: UITableViewDelegate {
    private func addSectionNames() {
        for stock in allStocks where !headerNames.contains(stock.dateForHeader) {
            headerNames.append(stock.dateForHeader)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(headerNames.count)
        return headerNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(headerNames[section])
        return headerNames[section]
    }
}

extension StockListViewController: UITableViewDataSource {
//    private func filterStockBySection(section: Int) -> [Stock] {
//        let stocksForSection = allStocks.filter { $0.dateForHeader == headerName[section] }
//        return stocksForSection
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stocksForSection = allStocks.filter { $0.dateForHeader == headerNames[section] }
        print(stocksForSection)
        return stocksForSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockCell = stockListTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let currentStock = allStocks[indexPath.row]
        stockCell.textLabel?.text = currentStock.date
        
        return stockCell
    }
    
    
}
