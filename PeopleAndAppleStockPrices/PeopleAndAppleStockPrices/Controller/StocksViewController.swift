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
        print()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stocksTableView.indexPathForSelectedRow,
            let stocksDetailViewController = segue.destination as? StocksDetailViewController else {return}
        let stock = stocks[indexPath.row]
        stocksDetailViewController.stock = stock

        
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
        
        var myString = String()
        let stocks = filterByDates()[section]
        for stock in stocks{
            if stock.date.contains("2016-12"){
                myString = "December - 2016 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-01"){
                myString = "January - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-02"){
                myString = "February - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-03"){
                myString = "March - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-04"){
                myString = "April - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-05"){
                myString = "May - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-06"){
                myString = "June - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-07"){
                myString = "July - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-08"){
                myString = "August - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-09"){
                myString = "September - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-10"){
                myString = "October - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-11"){
                myString = "November - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-12"){
                myString = "December - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
           } else if stock.date.contains("2018-01"){
                myString = "January - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-02"){
                myString = "February - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-03"){
                myString = "March - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-04"){
                myString = "April - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-05"){
                myString = "May - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-06"){
                myString = "June - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-07"){
                myString = "July - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-08"){
                myString = "August - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-09"){
                myString = "September - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-10"){
                myString = "October - 2018 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2018-11"){
                myString = "November - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
            } else if stock.date.contains("2017-12"){
                myString = "December - 2017 Average: $\(Double(round(100 * stocks.reduce(0){$0 + $1.open / Double(stocks.count)})/100))"
        }
            
        
            
        }
        return myString
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = filterByDates()[indexPath.section][indexPath.row]
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
        
    }
    
    
}
