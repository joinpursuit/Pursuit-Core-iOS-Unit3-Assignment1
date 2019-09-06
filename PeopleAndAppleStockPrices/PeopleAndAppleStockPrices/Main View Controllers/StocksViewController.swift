//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    var stocksfromJson: [Stock]!
    
    var groupedStocks: [String: [Stock]]!
    
    var sections: [String]!
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    private func configureTableView() {
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.rowHeight = 45
    }
    private func loadData() {
        guard let pathToUsersFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError("Couldn't find file")}
        
        let url = URL(fileURLWithPath: pathToUsersFile)
        
        do {
            let data = try
                Data(contentsOf: url)
            let StockFromJSON = try
                Stock.getStock(from: data)
            stocksfromJson = StockFromJSON
            groupedStocks = Stock.buildGroupStocks(stocksfromJson)
q            sections = Array(groupedStocks.keys)
            sections = Stock.sortSections(arr: sections)

        } catch {
            fatalError("Couldn't get Star Wars from JSON \(error)")
        }
    }
    


}
extension StocksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sections[section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        return stocks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = sections[indexPath.section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        let currentStock = stocks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = "$\(currentStock.openPrice)"
        cell.detailTextLabel?.text = currentStock.getDateInStringFormat()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionKey = sections[section]
        guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
        
        return "\(sectionKey.changeDateFormatForHeader(dateFormat: "yyyy-MM"))          Average Price: $\(Stock.getAverageForMonth(arr: stocks))"
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "stockCell":
            guard let DetailVC = segue.destination as? StocksDetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = stocksTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            
            let sectionKey = sections[selectedIndexPath.section]
            guard let stocks = groupedStocks[sectionKey] else {fatalError("no stocks found")}
            let currentStock = stocks[selectedIndexPath.row]
            
            DetailVC.stock = currentStock
        default:
            fatalError("unexpected segue identifies")
        }
    }

}

extension StocksViewController: UITableViewDelegate {

}
