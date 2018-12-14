//
//  StockSearchViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockSearchViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    var userStock = [Stocks]()
    
    //The following is used in the tableview
    var stockArray = [StockClass]()
    var stockAveragesDict = [String:Double]()
    var stocksArrangedByMonthYear = [[StockClass]]()
    var monthYearValues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        calculateAveragesAndLoadStocks()
    }
    
    func calculateAveragesAndLoadStocks() {
        for stock in userStock {
            
            let eachDate = stock.date
            let yearIndex = eachDate.index(eachDate.startIndex, offsetBy: 4)
            let year = eachDate[..<yearIndex]

            let monthStartIndex = eachDate.index(eachDate.startIndex, offsetBy: 5)
            let monthEndIndex = eachDate.index(eachDate.startIndex, offsetBy: 7)
            let monthNumberString = eachDate[monthStartIndex..<monthEndIndex]
            let monthNumberInt = Int(monthNumberString)

            let monthNames = ["January", "February", "March", "April","May","June","July","August","September","October","November","December"]

            let monthName = monthNames[monthNumberInt!-1]
            var monthYear = monthName + " - " + year

            if monthYearValues.contains(monthYear) == false {
                monthYearValues.append(monthYear)
            }
            

            let label = stock.label
            let vwap = stock.vwap
            let open = stock.open
            let close = stock.close
            let change = stock.change
            

            let stockToAdd = StockClass(date: eachDate, open: open, close: close, vwap: vwap ?? 0, monthYear: monthYear, label: label,change: change)

            stockArray.append(stockToAdd)
        }

        for element in monthYearValues {
            var totalVal = 0.0
            var totalCount = 0.0
            for stock in stockArray {
                if stock.monthYear == element {
                    totalVal = totalVal + (stock.close + stock.open)/2
                    totalCount = totalCount + 1
                }
            }
            let monthAverage = totalVal / totalCount
            
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            let roundedMonthAverage = round(monthAverage * multiplier) / multiplier
            print(roundedMonthAverage)
            
            stockAveragesDict[element] = monthAverage
        }
        print(stockAveragesDict)
        
        for i in 0..<monthYearValues.count {
            var specificArray = [StockClass]()
            for item in stockArray {
                if item.monthYear == monthYearValues[i] {
                    specificArray.append(item)
                }
            }
            stocksArrangedByMonthYear.append(specificArray)
        }
        print(stocksArrangedByMonthYear)
    }
    
    func setSections(date: String)->(month: String,year: String) {
        let detail = date.components(separatedBy: "-")
        return (detail[1], detail[0])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else { fatalError("error is in here")}
        let stockToSend = stocksArrangedByMonthYear[indexPath.section][indexPath.row]
        destination.stocksToSet = stockToSend
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                do{
                self.userStock = try JSONDecoder().decode([Stocks].self, from: data)
                }catch{
                    print(error)
                }
            }
        }
    }
}

extension StockSearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        _ = UITableViewCell()
        let monthYearSection = stocksArrangedByMonthYear[indexPath.section]
        let theStock = monthYearSection[indexPath.row]

        cell.textLabel?.text = theStock.date
        cell.detailTextLabel?.text = "$" + String(format: "%.2f", theStock.open)
        //cell.detailTextLabel?.text = currentStocks.open.description
     
         return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return monthYearValues.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //This needs to be updated with code that indicates the number of stocks for each month
        return stocksArrangedByMonthYear[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // return  monthYearValues[section]
        let average = String(format: " $%.02f", stockAveragesDict[monthYearValues[section]] ?? 0)
        return  "\(monthYearValues[section]): Average:\(average)"
        
    }
    
}
