//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Leandro Wauters on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    var stocks = [Stocks]()
   
    @IBOutlet weak var stocksTableView: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        loadData()
        dump(stocks)
        print()
    }
    func loadData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
                do {
                    self.stocks = try JSONDecoder().decode([Stocks].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    func filterByDates() ->[[Stocks]]{
        let filteredYear2016 = [stocks.filter{$0.date.contains("2016-12")}]
        let filteredYear2017FirstHalf = [stocks.filter{$0.date.contains("2017-01")},stocks.filter{$0.date.contains("2017-02")},stocks.filter{$0.date.contains("2017-02")},stocks.filter{$0.date.contains("2017-03")},stocks.filter{$0.date.contains("2017-04")},stocks.filter{$0.date.contains("2017-05")},stocks.filter{$0.date.contains("2017-06")}]
        let filteredYear2017SecondHalf = [stocks.filter{$0.date.contains("2017-07")},stocks.filter{$0.date.contains("2017-08")},stocks.filter{$0.date.contains("2017-07")},stocks.filter{$0.date.contains("2017-09")},stocks.filter{$0.date.contains("2017-10")}, stocks.filter{$0.date.contains("2017-11")}, stocks.filter{$0.date.contains("2017-12")}]
        let filteredYear2018FirstHalf = [stocks.filter{$0.date.contains("2018-01")},stocks.filter{$0.date.contains("2018-02")},stocks.filter{$0.date.contains("2018-03")},stocks.filter{$0.date.contains("2018-04")},stocks.filter{$0.date.contains("2018-05")}, stocks.filter{$0.date.contains("2018-06")}]
        let filteredYear2018SecondHalf = [stocks.filter{$0.date.contains("2018-07")}, stocks.filter{$0.date.contains("2018-08")},stocks.filter{$0.date.contains("2018-09")},stocks.filter{$0.date.contains("2018-10")},stocks.filter{$0.date.contains("2018-11")},stocks.filter{$0.date.contains("2018-12")}]
        
        return filteredYear2016 + filteredYear2017FirstHalf + filteredYear2017SecondHalf + filteredYear2018FirstHalf + filteredYear2018SecondHalf
    }
    
}
extension StocksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterByDates()[section].count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Number Of Sections: \(filterByDates().count)")
        return filterByDates().count
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = filterByDates()[indexPath.section][indexPath.row]
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
        
    }
    
    
}
