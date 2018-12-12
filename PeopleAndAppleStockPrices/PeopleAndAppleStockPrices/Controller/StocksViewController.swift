//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    var stockInfo = [StockInformation]()

    @IBOutlet weak var stockTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stockTableView.dataSource = self
        title = "Stocks"
      

    }
    
    func loadData(){
        if let pathway = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let url = URL.init(fileURLWithPath: pathway)
                do {
                        let data = try Data.init(contentsOf: url)
                    let stockDetails = try JSONDecoder().decode([StockInformation].self, from: data)
                    stockInfo = stockDetails
            
                } catch {
                    print(error)
                }
            }
}
}



extension StocksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return stockInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stockInfo[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
}
}
