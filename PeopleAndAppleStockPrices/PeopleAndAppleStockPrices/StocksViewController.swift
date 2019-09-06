//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allStock = [Stocks]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //Array that stores all unique sections dates
    var sectionNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stock Prices"
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        loadDatesForSections()
    }
    func retrieveStocksForAGivenSection(_ section: Int) -> [Stocks] {
        return allStock.filter{$0.sectionName == sectionNames[section]}
    }
    
    //Populating the array with unique section dates
    func loadDatesForSections() {
        for stock in allStock where !sectionNames.contains(stock.sectionName){
                sectionNames.append(stock.sectionName)
        }
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl) {
                do {
                    self.allStock = try JSONDecoder().decode([Stocks].self, from: data).sorted{$0.date < $1.date }
                } catch {
                    print(error)
                }
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailVC = segue.destination as? StocksDetailViewController,
            let selectedStock = tableView.indexPathForSelectedRow else { return
                
        }
        let stockThisSection = retrieveStocksForAGivenSection(selectedStock.section)
        let thisStock = stockThisSection[selectedStock.row]
        
        stockDetailVC.info = thisStock
    }
}
extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveStocksForAGivenSection(section).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) 
        let stocksInSection = retrieveStocksForAGivenSection(indexPath.section)
        let stock = stocksInSection[indexPath.row]
        cell.textLabel?.text = "\(stock.date)"
        cell.detailTextLabel?.text = "\(String(format: "%.2f", stock.open))"
        if stock.close > stock.open {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let allStocksInThisSection = retrieveStocksForAGivenSection(section)

        var sum: Double = 0.0
        for stock in allStocksInThisSection {
            sum += stock.open
        }
        
        let average = sum / Double(allStocksInThisSection.count)
        return "\(sectionNames[section]) Average: $\(String(format: "%.2f", average))"
    }
}



