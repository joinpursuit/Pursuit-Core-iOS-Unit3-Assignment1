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
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        loadData()
    }
    func loadData(){
        
     
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            
            let myUrl = URL.init(fileURLWithPath: path)
            
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.stocks = try JSONDecoder().decode([AppleStocks].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailStocksViewController,
            let selectedIndexPath = stocksTableView.indexPathForSelectedRow else {return}
        let stockToSend = stocks[selectedIndexPath.row]
        destination.stocksView = stockToSend
    }
}


extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        let stockToSet = stocks[indexPath.row]
        cell.textLabel?.text = stockToSet.date
        cell.detailTextLabel?.text = String(stockToSet.open)
        if stockToSet.close > stockToSet.open {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .red
        }

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stocks.count
    }
    
}

