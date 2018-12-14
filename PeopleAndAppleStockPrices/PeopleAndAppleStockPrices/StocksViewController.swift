//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {

    @IBOutlet weak var stocksTableView: UITableView!
    
    @IBOutlet weak var stockLabel: UILabel!
    
    
    
    
    var stocks = [Stock]() {
        didSet {
            DispatchQueue.main.async {
                self.stocksTableView.reloadData()
            }
        }
    }
    var sectionsNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        loadData()
        fillSectionNames()
        title = "Stocks"
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: url) {
                do {
                    self.stocks = try JSONDecoder().decode([Stock].self, from: data).sorted{$0.date < $1.date}
                } catch {
                    print(error)
                }
                return
            }
        }
    }
    
    func stockBySection(section: Int) -> [Stock] {
        return stocks.filter{$0.sectionName == sectionsNames[section]}
    }
    
    func fillSectionNames() {
        for stock in stocks {
            if !sectionsNames.contains(stock.sectionName) {
                sectionsNames.append(stock.sectionName)
            }
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StocksDetailViewController,
        let selectedRow = stocksTableView.indexPathForSelectedRow else {return}
        let stockThisSection = stockBySection(section: selectedRow.row)
        let thisStock = stockThisSection[selectedRow.row]
        destination.aStock = thisStock
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySection(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockViewCell else {return UITableViewCell()}
        let stockInSection = stockBySection(section: indexPath.section)
        let stock = stockInSection[indexPath.row]
        cell.dateLabel?.text = "\(stock.date)"
        cell.openPriceLabel?.text = "\(String(format: "%.2f", stock.open))"
        if stock.open < stock.close {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .green
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let thisSection = sectionsNames[section]
        var sum = 0.0
        let stockInSection = stocks.filter{$0.sectionName == thisSection}
        for stock in stockInSection {
            sum += stock.open
        }
        let average = sum / Double(stockInSection.count)
        return thisSection + " " + "average: $\(String(format: "%.2f", average))"
    }
    
}


extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
