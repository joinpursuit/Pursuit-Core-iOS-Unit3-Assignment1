//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Biron Su on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    var stockInfo = [AppleStockInfo]() {
        didSet {
            stockTableView.reloadData()
        }
    }
    var month = [String]()
    var stocks = [[AppleStockInfo]]()
    var average = [[Double]]()
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stockTableView.indexPathForSelectedRow, let stockVC = segue.destination as? StockDetailController else {fatalError("Index path, stockVC is nil")}
        let appleStock = stocks[indexPath.section][indexPath.row]
        stockVC.stockInfo = appleStock
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    stockInfo = try JSONDecoder().decode([AppleStockInfo].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
        for i in 0..<stockInfo.count {
            let monthYear = "\(stockInfo[i].label.components(separatedBy: " ")[0]) \(stockInfo[i].date.components(separatedBy: "-")[0])" // monthYear = "Jan 2017"
            if !month.contains(monthYear) { // if month array doesn't contain monthYear "Jan 2017"
                month.append(monthYear) // Adds "Jan 2017" to month, month now has ["Jan 2017"] Value
                stocks.append([]) // Starts new matrix in the matrix array
                average.append([]) // same here
            }
            stocks[stocks.endIndex - 1].append(stockInfo[i]) // adds to the matrix array until the if statement is met
            average[average.endIndex - 1].append(stockInfo[i].open) // then it will add to the new matrix array it started
        }
    }
}
extension StockViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(month[section]):    Average: $\(String(format: "%.2f", average[section].reduce(0){$0 + $1}/Double(average[section].count))) "
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockCell else { return UITableViewCell()}
        let info = stocks[indexPath.section][indexPath.row]
        cell.leftLabel.text = info.date
        cell.rightLabel.text = String(format: "%.2f", info.open)
        return cell
    }
}

