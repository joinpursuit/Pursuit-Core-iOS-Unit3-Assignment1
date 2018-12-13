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
//    stockInfo[section].reduce{} //add them all and divide by count
    
    let x = getMonthYear(dateString: stockInfo[section][0].date)
    let y = stockInfo[section].reduce(0){$0 + $1.vwap}
    let z = y / Double(stockInfo[section].count)
    
    print("this is y: \(y)")
    print("this is z: \(z)")
    
  
    
    
    return "\(x.year) - \(x.month). Average: $\(String(format: "%.2f", z))"
    
  
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
    
  }
  
  
}


//    switch section{
//    case 1:
//      return "February"
//
//    case 2:
//      return "March"
//
//    case 3:
//      return "April"
//
//    case 5:
//      return "May"
//
//    case 6:
//      return "June"
//
//    case 7:
//      return "July"
//
//    case 8:
//      return "August"
//
//    case 9:
//      return "September"
//
//    case 10:
//      return "October"
//
//    case 11:
//      return "November"
//
//    case 12:
//      return "December"
//
//    default:
//      return "Didn't find section"
//    }
