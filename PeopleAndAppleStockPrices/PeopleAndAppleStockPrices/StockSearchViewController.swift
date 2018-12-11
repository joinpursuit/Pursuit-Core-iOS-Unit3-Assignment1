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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
//        dump(userStock)
        print("the first element is:")
        print(userStock[0])
        calculateAverages()
    }
    
    func calculateAverages() {
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
            let monthYear = monthName + " - " + year
            print(monthYear)

        }

    }
    
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? StockDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else { fatalError("error is in here")}
        let stockInfo = userStock[indexPath.row]
        destination.stocksToSet = stockInfo
        
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

func tableView(_ tableView: UITableView, didSelectForRow indexPath: IndexSet){
}

extension StockSearchViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        let placeholder = 5
        return placeholder
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //This needs to be updated with code that indicates the number of stocks for each month
        return userStock.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let currentStocks = userStock[indexPath.row]
        cell.textLabel?.text = currentStocks.date
         return cell
    }
}






