//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var stocksTableView: UITableView!
    
    // MARK: Properties
    var stocksModel = [Stocks]()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        loadData()
    }
    
    // MARK: Private Methods
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("Could not find JSON file")
        }
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let stocksFromJSON = Stocks.getStocks(from: data)
            stocksModel = stocksFromJSON
        } catch {
            fatalError()
        }
    }

    // MARK: Navigation Metod
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailStocks" {
            guard let detailStockVC = segue.destination as? DetailStocksViewController else {
                fatalError()
            }
            guard let selectedIndexPath = stocksTableView.indexPathForSelectedRow else {
                fatalError()
            }
            detailStockVC.stock = stocksModel[selectedIndexPath.row]
        }
    }
    

}

// MARK: Extensions
extension StocksViewController: UITableViewDelegate {
    
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = stocksModel[indexPath.row].date
        cell.detailTextLabel?.text = stocksModel[indexPath.row].open.description
        return cell
    }
    
    
}
