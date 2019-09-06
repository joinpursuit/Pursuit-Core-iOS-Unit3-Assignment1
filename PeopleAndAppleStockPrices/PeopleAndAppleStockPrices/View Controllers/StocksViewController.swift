//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stocks = [StockPrice]() {
        didSet {
            stocksTableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStocksTableView()
        getStocks()
    }
    
    //MARK: DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks[indexPath.row]
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = "$" + String(format: "%.2f", stock.open ?? 0)
        cell.detailTextLabel?.text = stock.date
        return cell
    }
    
    //MARK: Delegate Methods
    
    //MARK: -- Custom Functions
    private func configureStocksTableView() {
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
    }
    
    func getStocks() {
        guard let pathToStocksInfoJSON = Bundle.main.path(forResource: "applstockinfo", ofType: ".json") else { return }
        let url = URL(fileURLWithPath: pathToStocksInfoJSON)
        do {
            let stocksData = try Data(contentsOf: url)
            let stocksFromJSON = try JSONDecoder().decode([StockPrice].self, from: stocksData)
            self.stocks = stocksFromJSON.sorted(by: { (stock1, stock2) -> Bool in
                stock1.date! < stock2.date!
            })
        } catch let error {
            print(error)
            return
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockSegueIdentifier = segue.identifier else { return }
        switch stockSegueIdentifier {
        case "stockDetailsSegue":
            guard let stockDetailsVC = segue.destination as? StockDetailsViewController else { return }
            let indexPathForSelectedStock = stocksTableView.indexPathForSelectedRow
            stockDetailsVC.stockForDate = stocks[indexPathForSelectedStock!.row]
        default:
            return
        }
    }

}
