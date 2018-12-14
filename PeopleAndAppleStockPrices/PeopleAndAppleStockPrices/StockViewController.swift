//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ramu on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView!
    
    var stockInfo = [AppleStockData]()
    var sectionNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        loadData()
        getSectionNames()
        
        
    }
    func stockBySection(SectionNumber: Int) -> [AppleStockData] {
        return stockInfo.filter({$0.sectionName == sectionNames[SectionNumber]})
    }
    func getSectionNames() {
        for stock in stockInfo {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailedStockViewController = segue.destination as? DetailedStockViewController,
            let stockCell = sender as? UITableViewCell, let indexPath = stockTableView.indexPath(for: stockCell)
            else { return }
        let stockInCurrentSection = stockBySection(SectionNumber: indexPath.section)
        let stock = stockInCurrentSection[indexPath.row]
        DetailedStockViewController.stock = stock
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json")
        {
            let myUrl = URL.init(fileURLWithPath: path)
            
                do {
                     let data = try Data.init(contentsOf: myUrl)
                    let stocks = try JSONDecoder().decode([AppleStockData].self, from: data)
                    stockInfo = stocks.sorted(by: { (StockA, StockB) -> Bool in
                        return StockA.date < StockB.date})
                } catch {
                    print(error)
                }
            }
        }
    }


extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySection(SectionNumber: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stockToSet = stockInfo[indexPath.row]
        cell.textLabel?.text = stockToSet.date
        cell.detailTextLabel?.text = "\(stockToSet.open)"
        let stockInCurrentSection = stockBySection(SectionNumber: indexPath.section)
        let stock = stockInCurrentSection[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.close)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
        
    }
    }

        extension StockViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                //        let currentSection = sectionNames[section]
                //        let stocksInCurrentSection = stockInfo.filter( {$0.sectionName == currentSection})
                return sectionNames[section]
            }
        }

    



