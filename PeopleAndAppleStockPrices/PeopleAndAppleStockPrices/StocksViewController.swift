//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    var stockList = [Stocks]()
    var stockMatrix = [[Stocks]]()
    var stockMonth = [String]()
    var average = [[Double]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stocks"
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        loadData()
        getHeaderInfo()

       
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.stockList = try JSONDecoder().decode([Stocks].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getHeaderInfo() {
        for i in 0..<stockList.count {
            let stockMonthYear = "\(stockList[i].label.components(separatedBy: " ")[0]) - \(stockList[i].date.components(separatedBy: "-")[0])"
            if !stockMonth.contains(stockMonthYear) {
                stockMonth.append(stockMonthYear)
                stockMatrix.append([])
                average.append([])
                
            }
            stockMatrix[stockMatrix.endIndex - 1].append(stockList[i])
            average[stockMatrix.endIndex - 1].append(stockList[i].open)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stocksTableView.indexPathForSelectedRow, let stocksDetailViewController = segue.destination as? StocksDetailViewController else { return }
        let stocks = stockMatrix[indexPath.section][indexPath.row]
        stocksDetailViewController.stocks = stocks
    }
    
    
    
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockMatrix[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath) as? StocksCell else { return UITableViewCell()}
        let stockToSet = stockMatrix[indexPath.section][indexPath.row]
        cell.leftLabel.text = stockToSet.date
        cell.rightLabel.text = String(format: "%.02f", stockToSet.open)
        return cell
    }
}

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let averageDollars = String(format: "%.02f", average[section].reduce(0) {$0 + $1} / Double(average[section].count))
        return "\(stockMonth[section])  Average: $\(averageDollars)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockMonth.count
    }
}
