//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
  
  var stockInfo = [Stocks]()
  
  @IBOutlet weak var stocksTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Stocks"
    makeSections()
    stocksTableView.dataSource = self
  }
  
  
  
  
  
  
  // if month, year is different from previous variable (month, year)
  // e.g (11, 2016) => (12, 2016)
  
  // if (previous != current)
  //stockPriceSections.append([Stocks]())
  
  //        print(getMonthYear(dateString: stockPrice.date))
  
  private func makeSections() -> [[Stocks]]{
    var stockPriceSections = [[Stocks]]()
    
    if let stockResults = loadData() {
      // make 2d array
      
      stockPriceSections.append([Stocks]()) // 2016-12-09 // break into components [0] year, [1] month
      var startIndex = 0
      var date = (month: "12", year:"2016")
      
      for stockPrice in stockResults {
        
        if date != getMonthYear(dateString: stockPrice.date){
          date = getMonthYear(dateString: stockPrice.date)
          stockPriceSections.append([Stocks]())
          startIndex += 1
        } else {
          stockPriceSections[startIndex].append(stockPrice)
        }
      }
    }
    return stockPriceSections
  }
  
  // 2016-12-02
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
    
    let stockToSegue = stockInfo[indexPath.row]
    StockDetailedVC.stockDetailed = stockToSegue
    
  }
  
}

extension StockViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stockInfo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = stocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockCustomCellTableViewCell else {return UITableViewCell()}
    
    let currentStock = stockInfo[indexPath.row]
    
    cell.date.text = currentStock.date
    cell.openingPrice.text = NSString(format: "%.2f", currentStock.open) as String
    
    return cell
    
  }
}

extension StockViewController: UITableViewDelegate{
  func numberOfSections(in tableView: UITableView) -> Int {
    
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    <#code#>
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
}

