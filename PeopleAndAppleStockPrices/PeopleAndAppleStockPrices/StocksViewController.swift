//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {

    var stocks = [StockPrice]()
    //var appleStocks = [AppleStock]
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
        
        stockTableView.dataSource = self
    }
    func loadData() {
        var results = [StockPrice]()
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.stocks = try JSONDecoder().decode([StockPrice].self, from: data)
                    results = stocks.sorted {$0.date > $1.date}
                } catch {
                    print(error)
                }
            }
        }
    }



//    }
}
extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stockToSet = stocks[indexPath.row]
        cell.textLabel?.text = stockToSet.date
        return cell
}


}
