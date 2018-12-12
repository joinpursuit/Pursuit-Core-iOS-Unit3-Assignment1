//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    var stocks = [StockModel]() {
        didSet {
            stockTableView.reloadData()
        }
    }
    var sectionDate = [String]()
    var monthString = ""
    var yearString = ""
    var monthNumberToWord = ""
    var stocksArray = [[StockModel]]()
    var average = [[Double]]()
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stockTableView.indexPathForSelectedRow,
            let stocksDetailViewController = segue.destination as? StocksDetailViewController else {return}
        let stock = stocksArray[indexPath.section][indexPath.row]
        stocksDetailViewController.stockSelected = stock
    }
    func getDateMonth(dateString: String) {
        let components = dateString.components(separatedBy: "-")
        monthString = components[1]
        yearString = components[0]
        
        switch monthString {
        case "01":
            return monthNumberToWord = "January"
        case "02":
            return monthNumberToWord = "February"
        case "03":
            return monthNumberToWord = "March"
        case "04":
            return monthNumberToWord = "April"
        case "05":
            return monthNumberToWord = "May"
        case "06":
            return monthNumberToWord = "June"
        case "07":
            return monthNumberToWord = "July"
        case "08":
            return monthNumberToWord = "August"
        case "09":
            return monthNumberToWord = "September"
        case "10":
            return monthNumberToWord = "October"
        case "11":
            return monthNumberToWord = "November"
        case "12":
            return monthNumberToWord = "December"
        default:
            print("Error")
        }
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    stocks = try JSONDecoder().decode([StockModel].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
        for i in 0..<stocks.count {
            getDateMonth(dateString: stocks[i].date)
            let monthYear = "\(monthNumberToWord) \(yearString)"
            
            if !sectionDate.contains(monthYear) {
                sectionDate.append(monthYear)
                print(sectionDate)
                stocksArray.append([])
                average.append([])
            }
            stocksArray[stocksArray.endIndex - 1].append(stocks[i])
            average[average.endIndex - 1].append(stocks[i].open)
        }
        
    }
}
extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDate.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let averageTotal = String(format: "%.2f", average[section].reduce(0){$0 + $1}/Double(average[section].count))
        return "\(sectionDate[section]): Average: $\(averageTotal) "
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableViewCell else { return UITableViewCell()}
        let stockToSet = stocksArray[indexPath.section][indexPath.row]
        cell.dateLabel.text = stockToSet.date
        cell.openPriceLabel.text = String(format: "%.2f", stockToSet.open)
        return cell
    }
}
