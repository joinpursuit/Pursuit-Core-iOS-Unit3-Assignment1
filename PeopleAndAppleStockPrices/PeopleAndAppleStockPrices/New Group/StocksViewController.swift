//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jane Zhu on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var stocksSearchBar: UISearchBar!
    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks: [Stocks] = []
//    {
//        didSet {
//            stocksTableView.reloadData()
//        }
//    }
    var stocksByMonthAndYear: [[Stocks]] = [] {
        didSet {
            stocksTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        for year in 2016...2018 {
            for month in 1...12 {
                let correctMonth = formatMonthCorrectly(month)
                let results = stocks.filter{
                    let arr = $0.date.components(separatedBy: "-")
                    if monthLookingFor(is: arr, from: correctMonth) && yearLookingFor(is: arr, from: year.description) {
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
        //print(stocksByMonthAndYear[0].filter{$0.open > 0})
        //print(stocksByMonthAndYear)
    }
    
    private func formatMonthCorrectly(_ month: Int) -> String {
        switch month {
        case 1:
            return "01"
        case 2:
            return "02"
        case 3:
            return "03"
        case 4:
            return "04"
        case 5:
            return "05"
        case 6:
            return "06"
        case 7:
            return "07"
        case 8:
            return "08"
        case 9:
            return "09"
        case 10:
            return "10"
        case 11:
            return "11"
        case 12:
            return "12"
        default:
            return "invalid month"
        }
    }
    
    private func monthLookingFor(is arr: [String], from month: String) -> Bool {
        if arr[1] == month {
            return true
        } else {
            return false
        }
    }
        
    private func yearLookingFor(is arr: [String], from year: String) -> Bool {
        if arr[0] == year {
            return true
        } else {
            return false
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
        cell.detailTextLabel?.text = stockToSet.open.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "December 2016: Average:"
            case 1:
            return "January 2017: Average"
            case 2:
            return "February 2017: Average"
            case 3:
            return "March 2017: Average"
            case 4:
            return "April 2017: Average"
            case 5:
            return "May 2017: Average"
            case 6:
            return "June 2017: Average"
            case 7:
            return "July 2017: Average"
            case 8:
            return "August 2017: Average"
            case 9:
            return "September 2017: Average"
            case 10:
            return "October 2017: Average"
            case 11:
            return "November 2017: Average"
            case 12:
            return "December 2017: Average"
            case 13:
            return "January 2018: Average"
            case 14:
            return "February 2018: Average"
            case 15:
            return "March 2018: Average"
            case 16:
            return "April 2018: Average"
            case 17:
            return "May 2018: Average"
            case 18:
            return "June 2018: Average"
            case 19:
            return "July 2018: Average"
            case 20:
            return "August 2018: Average"
            case 21:
            return "September 2018: Average"
            case 22:
            return "October 2018: Average"
            case 23:
            return "November 2018: Average"
            case 24:
            return "December 2018: Average"
            default:
            return "date not found"
        }
    }
}

extension StocksViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksByMonthAndYear.count
    }
}
