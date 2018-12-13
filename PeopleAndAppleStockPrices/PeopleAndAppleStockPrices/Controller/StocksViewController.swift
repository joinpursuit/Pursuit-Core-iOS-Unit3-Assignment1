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
    var stocksBySection = [StockSection]()

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
                    //stockInfo = stockDetails
                    stocksBySection = StockSection.createSections(from: stockDetails)
            
                } catch {
                    print(error)
                }
            }
}
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockIndexpath = stockTableView.indexPathForSelectedRow, let stockDetails = segue.destination as? StockDetailViewController else {return}
        let currentStock = stocksBySection[stockIndexpath.section].stocks[stockIndexpath.row]
        stockDetails.stock = currentStock
        
    }
    
}

extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksBySection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return stocksBySection[section].stocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stockSection = stocksBySection[section]
        return "\(stockSection.label)           $\(stockSection.average)"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stocksBySection[indexPath.section].stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(format: "%0.2f", (stock.open))
        return cell
}
}


