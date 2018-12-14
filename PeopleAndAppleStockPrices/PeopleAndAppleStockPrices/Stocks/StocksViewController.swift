//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Genesis Mosquera on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView!
    
    var allStocks = [Stock]()
    var sectionNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        loadData()
        getSectionNames()
    }
    
    func stocksBySection(SectionNumber: Int) -> [Stock] {
        return allStocks.filter({$0.sectionName == sectionNames[SectionNumber]})
    }
    
    func getSectionNames() {
        for stock in allStocks {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let StocksDetailViewController = segue.destination as?
            StocksDetailViewController,
            let stockCell = sender as? UITableViewCell, let indexPath = stockTableView.indexPath(for: stockCell)
            else { return }
        let stockInThisSection = stocksBySection(SectionNumber: indexPath.section)
        let stock = stockInThisSection[indexPath.row]
        StocksDetailViewController.stock = stock 
        
        
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url) {
                do {
                    self.allStocks = try JSONDecoder().decode([Stock].self, from: data)
                    self.allStocks = allStocks.sorted(by: { (Stock1, Stock2) -> Bool in
                        return Stock1.date < Stock2.date
                    })
                    
                    
                } catch {
                    
                }
                
            }
        }
        
        
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksBySection(SectionNumber: section).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stocksInCurrentSection = stocksBySection(SectionNumber: indexPath.section)
        let stock = stocksInCurrentSection[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.close)"
        return cell
    }
    
    
    
    
}

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let thisSection = sectionNames[section]
        //        let stocksInThisSection = allStocks.filter({$0.sectionName == thisSection})
        return sectionNames[section]
    }
}
