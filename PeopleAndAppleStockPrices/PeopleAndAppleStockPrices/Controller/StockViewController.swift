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
    var array = [[String]]()
    var arrayYear = [[String]]()
    var month = [String]()
    var stocks = [[AppleStockInfo]]()
    var stockDate = ""
    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stockTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // stockSearchBar.delegate = self
        stockTableView.dataSource = self
        loadData()
        
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
            array.append(stockInfo[i].label.components(separatedBy: " "))
            arrayYear.append(stockInfo[i].date.components(separatedBy: "-"))
            if !month.contains("\(array[i][0]) \(arrayYear[i][0])") {
                month.append("\(array[i][0]) \(arrayYear[i][0])")
                stocks.append([])
            }
            stocks[stocks.endIndex - 1].append(stockInfo[i])
        }
    }
}

extension StockViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(month[section])"
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
