//
//  StockTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var stocks = [Stock]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var groupedStocksKey: [String] {
        Dictionary(grouping: stocks) {$0.stub}
            .sorted {$0.key < $1.key }
            .map {$0.key}
    }
    
    private var groupedStocks: [[Stock]] {
        Dictionary(grouping: stocks) {$0.stub}
            .sorted {$0.key < $1.key }
            .map {$0.value}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StockDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            destination.stock = groupedStocks[indexPath.section][indexPath.row]
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: ".json") else {
            fatalError("Error ocurred trying to find file.")
        }
        let internalURL = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: internalURL)
            let stocks = try Stock.getStocks(from: data)
            self.stocks = stocks
        } catch {
            print("Error occured during decoding: \(error)")
        }
        
    }
}

extension StockTableViewController: UITableViewDelegate {}
extension StockTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedStocksKey[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedStocks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedStocks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        cell.textLabel?.text = groupedStocks[indexPath.section][indexPath.row].date
        
        cell.detailTextLabel?.text = String(format: "$ %.2f", groupedStocks[indexPath.section][indexPath.row].open)
        return cell
    }
    
    
}
