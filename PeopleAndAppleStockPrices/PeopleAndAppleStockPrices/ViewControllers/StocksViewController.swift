//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {

    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks = [StockData]() 
    var sectionNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        stocksTableView.delegate =  self
        loadData()
        getSectionNames()
        
    }
    
    func getSectionNames(){
        for stock in stocks {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    
    func stocksBySection(section: Int)->[StockData]{
        return stocks.filter({$0.sectionName == sectionNames[section]})
    }
    
    func loadData(){
        //decode json
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {return}
        
    
        //get the data
        //instance or url
        let myUrl = URL.init(fileURLWithPath: path)
        //init data with URl
        guard let data = try? Data(contentsOf: myUrl) else {return}
        do{
           let results = try JSONDecoder().decode([StockData].self, from: data)
            self.stocks = results
        }catch {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DVC = segue.destination as? StocksDetailViewController else { return }
        guard let cell = sender as? UITableViewCell else {return}
        guard let indexPath = stocksTableView.indexPath(for: cell) else {return}
        let stocks = stocksBySection(section: indexPath.section)
        let stock = stocks[indexPath.row]
        DVC.stock = stock
    }
    

}
extension StocksViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksBySection(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        let stocks = stocksBySection(section: indexPath.section)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stocks = stocksBySection(section: section)
        var average : Double = 0.0
        var sum = 0.0
        for stock in stocks {
            sum += stock.open
        }
        average = sum/Double(stocks.count)
        return sectionNames[section] + " " + "\(average)"
    }
    
    
}
