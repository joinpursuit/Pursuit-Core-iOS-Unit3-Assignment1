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
    var stockPrices = [[Stocks]]()
    var previousDate = ""
    var startIndex = 0
    
    @IBOutlet weak var stocksTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        loadData()
        matrix()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stocksTableView.indexPathForSelectedRow,
            let stocksDetailViewController = segue.destination as? StocksDetailViewController else {return}
        let stock = stocks[indexPath.row]
        stocksDetailViewController.stock = stock

        
    }
    func matrix(){
        stockPrices.append([Stocks]())
        for stock in stocks {
            let dateMonth = getDateMonth(dateString: stock.date)
            let currentDate = dateMonth.month + "-" + dateMonth.year
            if previousDate.isEmpty {previousDate = dateMonth.month + "-" + dateMonth.year}
            if currentDate != previousDate {
                stockPrices.append([Stocks]())
                startIndex += 1
            }
            stockPrices[startIndex].append(stock)
            previousDate = dateMonth.month + "-" + dateMonth.year
        }
    }
    
    func getDateMonth(dateString: String) -> (month: String, year: String) {
        let components = dateString.components(separatedBy: "-")
        return (components[1], components[0])
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
}



extension StocksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPrices[section].count

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockPrices.count

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var myString = String()
        let stocks = stockPrices[section]
        for stock in stocks{
            if stock.date.contains("2016-12"){
                myString = "December - 2016 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-01"){
                myString = "January - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-02"){
                myString = "February - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-03"){
                myString = "March - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-04"){
                myString = "April - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-05"){
                myString = "May - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-06"){
                myString = "June - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-07"){
                myString = "July - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-08"){
                myString = "August - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-09"){
                myString = "September - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-10"){
                myString = "October - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-11"){
                myString = "November - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-12"){
                myString = "December - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
           } else if stock.date.contains("2018-01"){
                myString = "January - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-02"){
                myString = "February - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-03"){
                myString = "March - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-04"){
                myString = "April - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-05"){
                myString = "May - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-06"){
                myString = "June - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-07"){
                myString = "July - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-08"){
                myString = "August - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-09"){
                myString = "September - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-10"){
                myString = "October - 2018 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2018-11"){
                myString = "November - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
            } else if stock.date.contains("2017-12"){
                myString = "December - 2017 Average: $\(Reduce.reduce(stocks: stocks))"
        }



        }
        return myString
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stockPrices[indexPath.section][indexPath.row]
        let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stocksCell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell

    }


}
