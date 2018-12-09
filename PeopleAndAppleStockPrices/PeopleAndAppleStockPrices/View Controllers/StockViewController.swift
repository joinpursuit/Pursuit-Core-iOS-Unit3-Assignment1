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
  //ojo: this is starts as an array 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
      dump(stockInfo)
      stocksTableView.dataSource = self
    }
    
  func loadData() {
    if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
      let stockURL = URL(fileURLWithPath: path)
      if let stockData = try? Data(contentsOf: stockURL){
        do{
          self.stockInfo = try JSONDecoder().decode([Stocks].self, from: stockData)
        }catch{
          print(error)
        }
      }
    }
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
//  func numberOfSections(in tableView: UITableView) -> Int {
//
//  }
//
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
 
}

