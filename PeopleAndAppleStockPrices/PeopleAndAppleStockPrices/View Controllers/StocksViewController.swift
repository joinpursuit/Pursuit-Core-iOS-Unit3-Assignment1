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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
