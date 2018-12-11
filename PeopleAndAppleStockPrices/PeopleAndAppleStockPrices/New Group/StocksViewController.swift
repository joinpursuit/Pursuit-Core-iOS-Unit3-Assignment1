//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jane Zhu on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks: [Stocks] = []
    var stocksByMonthAndYear: [[Stocks]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        for year in 2016...2018 {
            for month in 1...12 {
                let formattedMonth = StocksHelperPropertiesAndMethods.formatMonthCorrectly(month)
                let results = stocks.filter{
                    let dateAsArr = $0.date.components(separatedBy: "-")
                    if StocksHelperPropertiesAndMethods.monthLookingFor(is: dateAsArr, from: formattedMonth) && StocksHelperPropertiesAndMethods.yearLookingFor(is: dateAsArr, from: year.description) {
                        return true
                    } else {
                        return false
                    }
                    }
                if !results.isEmpty {
                stocksByMonthAndYear.append(results)
                }
            }
        }
    }
    
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    self.stocks = try JSONDecoder().decode([Stocks].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StocksDetailViewController, let indexPath = stocksTableView.indexPathForSelectedRow else { return }
        let stockToSend = stocksByMonthAndYear[indexPath.section][indexPath.row]
        destination.stock = stockToSend
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksByMonthAndYear[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        let stockToSet = stocksByMonthAndYear[indexPath.section][indexPath.row]
        cell.textLabel?.text = stockToSet.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", stockToSet.open)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateAsArr = stocksByMonthAndYear[section].first!.date.components(separatedBy: "-")
        let month = StocksHelperPropertiesAndMethods.monthDictionary[dateAsArr[1]]
        let year = dateAsArr[0]
        let average = String(format: "%.2f", StocksHelperPropertiesAndMethods.calculateMonthlyAverage(from: stocksByMonthAndYear[section]))
        return month! + " " + year + " ~ Average: $" + average
    }
}

extension StocksViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksByMonthAndYear.count
    }
}
