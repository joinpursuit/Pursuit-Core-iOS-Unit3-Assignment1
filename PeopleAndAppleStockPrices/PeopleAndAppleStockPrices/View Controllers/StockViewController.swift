//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
  
  
  var stockInfo = [[Stocks]]()
  //  var monthYear = (month:"", year:"")
  
  @IBOutlet weak var stocksTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Stocks"
    stockInfo = makeSections()
    stocksTableView.dataSource = self
  }
  
  
  private func makeSections() -> [[Stocks]]{
    var stockPriceSections = [[Stocks]]()
    
    
    if let stockResults = loadData() {
      
      stockPriceSections.append([Stocks]())
      
      var startIndex = 0
      
      var date = (month: "12", year:"2016")
      
      
      for stockPrice in stockResults {
        
        if date != getMonthYear(dateString: stockPrice.date){
          date = getMonthYear(dateString: stockPrice.date)
          stockPriceSections.append([Stocks]())
          startIndex += 1
          
        }
        stockPriceSections[startIndex].append(stockPrice)
      }
    }
    return stockPriceSections
  }
  
  //  2017-12-01 -> [2017,12,01] -> (12, 2017)
  
  func getMonthYear(dateString: String) -> (month: String, year: String) {
    let components = dateString.components(separatedBy: "-")
    return (components[1], components[0])
  }
  
  
  func loadData() -> [Stocks]? {
    var stocks: [Stocks]?
    if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
      let stockURL = URL(fileURLWithPath: path)
      if let stockData = try? Data(contentsOf: stockURL){
        do{
          stocks = try JSONDecoder().decode([Stocks].self, from: stockData)
        }catch{
          print(error)
        }
      }
    }
    return stocks
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = stocksTableView.indexPathForSelectedRow,
      let StockDetailedVC = segue.destination as? StockDetailedViewController
      else {fatalError("problems finding destination or indexPath in segue")}
    
    let stockToSegue = stockInfo[indexPath.section][indexPath.row]
    StockDetailedVC.stockDetailed = stockToSegue
    
  }
  
}

extension StockViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stockInfo[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
    
    let currentStock = stockInfo[indexPath.section][indexPath.row]
    
    cell.textLabel?.text = currentStock.date
    cell.detailTextLabel?.text = "$" + String(format: "%.2f", currentStock.open)
    
    return cell
    
  }
}

extension StockViewController: UITableViewDelegate{
  func numberOfSections(in tableView: UITableView) -> Int {
    return stockInfo.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    let monthDictionary = [01: "Jan", 02:"Feb", 03:"Mar", 04: "Apr", 05:"May", 06:"Jun", 07: "Jul", 08:"Aug", 09:"Sep", 10: "Oct", 11:"Nov", 12: "Dec" ]
    
    var stringToReturn = ""
    let accessToDateForSection = getMonthYear(dateString: stockInfo[section][0].date)
    let sumOfMonthOpenPrice = stockInfo[section].reduce(0){$0 + $1.open}
    let averageOfOpenPrice = sumOfMonthOpenPrice / Double(stockInfo[section].count)
    
    for (key, value) in monthDictionary{
      if Int(accessToDateForSection.month) == key {
        stringToReturn = "\(accessToDateForSection.year) - \(value).            Average: $\(String(format: "%.2f", averageOfOpenPrice))"
      }
    }
    return stringToReturn
    
  }
  
}

