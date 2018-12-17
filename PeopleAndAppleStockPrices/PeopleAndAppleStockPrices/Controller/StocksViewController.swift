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
    var sectionNames = [String]()
   

    @IBOutlet weak var stockTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        getSectionName()
        stockTableView.dataSource = self

        title = "Stocks"
      
    }
    
    func loadData(){
        if let pathway = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let url = URL.init(fileURLWithPath: pathway)
                do {
                        let data = try Data.init(contentsOf: url)
                    let stockDetails = try JSONDecoder().decode([StockInformation].self, from: data).sorted{$0.date < $1.date}
                    stockInfo = stockDetails
    
            
                } catch {
                    print(error)
                }
            }
}
    func getSectionName(){
        for stock in stockInfo {
            if !sectionNames.contains(stock.stockSectionName){
                sectionNames.append(stock.stockSectionName)
            }
        }
    }
    
    func stocksBySections(sectionNum: Int) -> [StockInformation]{
        
        return stockInfo.filter{$0.stockSectionName == sectionNames[sectionNum]}
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailViewController = segue.destination as? StockDetailViewController, let stockCell = sender as? UITableViewCell, let indexPathCustom = stockTableView.indexPath(for: stockCell) else {return}
        
        let stocks = stocksBySections(sectionNum: indexPathCustom.section)
        let stock = stocks[indexPathCustom.row]
       stockDetailViewController.stock = stock
        
    }
    
}

extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return stocksBySections(sectionNum: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stockSectionName = sectionNames[section]
        let stocksInSection = stockInfo.filter({$0.stockSectionName == stockSectionName})
        var sum = 0.0
        for stock in stocksInSection {
            sum += stock.open
        }
        let average = String(format: "%0.2f", sum / Double(stocksInSection.count))
        return "\(stockSectionName)                                  $\(average)"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stocksInSection = stocksBySections(sectionNum: indexPath.section)
        let stock = stocksInSection[indexPath.row]
        
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(format: "%0.2f", (stock.open))
        return cell
}
}


