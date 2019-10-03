//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var StocksTableView: UITableView!
    
//    var stockInfo = [Stocks]().sorted(by: {$0.date > $1.date}) {
//        didSet{
//            StocksTableView.reloadData()
//        }
//    }
//
    var stockInfo = [StocksByMonthAndYear]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStockData()
        StocksTableView.dataSource = self
        StocksTableView.delegate = self
    }
    private func loadStockData() {
           stockInfo = Stocks.getStocksSortedByMonthAndYear()
       }
    
//
//    func loadStockData() {
//        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType:"json")
//            else {
//                fatalError("applstockinfo.json file not found")
//        }
//        let internalUrl = URL(fileURLWithPath: pathToData)
//        do {
//            let data = try Data(contentsOf: internalUrl)
//            let stocksFromJSON = try
//                stockInfo = Stocks.getStocksData()
//        } catch {
//            print(error)
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // return stockInfo.count
        return stockInfo[section].stocks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return stockInfo.count
       }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stock = stockInfo[section]
        return "\(stock.month) \(stock.year).AVG: \(stock.getMonthAverage())"
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let rowToSetup = indexPath.row
        //let currentSection = indexPath.section
       // let dateAtRow = stockInfo[currentSection][rowToSetup]
        let stock = stockInfo[indexPath.section].stocks[indexPath.row]
        let cell = StocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
       // let setupInfo = stockInfo[indexPath.row]
        cell.textLabel?.text = "\(stock.day) \(stock.month) \(stock.year)"
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
}

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyBoard = storyboard?.instantiateViewController(withIdentifier: "StockDetailViewController") as? StockDetailViewController{
            storyBoard.allStocks = stockInfo[indexPath.section].stocks[indexPath.row]
        navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
}


