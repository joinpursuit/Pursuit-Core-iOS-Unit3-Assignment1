//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView!
    
    var stockDays = [StockDay]()
    var stockDaysByYear = [[StockDay]]()
    
    //stockDaysByMonth is what I need
    var stockDaysByMonth = [[StockDay]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        
        loadData()
        
        //2
        //filter by year
        for year in 2016...2018 {
            stockDaysByYear.append(stockDays.filter{ (stockDay) -> Bool in
                let currentDate = stockDay.date.components(separatedBy: "-")
                let currentYear = Int(currentDate[0])
                return year == currentYear
            })
        }
        
        //filter by month
        for yearStocks in stockDaysByYear {
            for month in 1...12 {
                let stockArr = yearStocks.filter { (stockDay) -> Bool in
                    let currentDate = stockDay.date.components(separatedBy: "-")
                    let currentMonth = Int(currentDate[1])!
                    return month == currentMonth
                }
                
                if stockArr.isEmpty {
                    continue
                }
                
                stockDaysByMonth.append(stockArr)
            }
        }
        
    }
    
    //1
    func loadData() {
        //get path(String) with guard let
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            print("path not found")
            return
        }
        //convert to URL and turn it into data in guard let (URL error)
        let url = URL.init(fileURLWithPath: path)
        
        if let data = try? Data.init(contentsOf: url) {
            do {
                self.stockDays = try JSONDecoder().decode([StockDay].self, from: data)
            } catch {
                print(error)
            }
        }
        //???Why this doesn't work
//        guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else {
//            print("Bad URL")
//            return
//        }
//
//        do {
//            self.stockDays = try JSONDecoder().decode([StockDay].self, from: data)
//        } catch {
//            print(error)
//        }
    }
    
    //6
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        guard let indexPath = stockTableView.indexPathForSelectedRow,
            let stockDetailVC = segue.destination as? StockDetailViewController
            else { return }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Stock"
        navigationItem.backBarButtonItem = backItem
        
        let stockDay = stockDaysByMonth[indexPath.section][indexPath.row]
        stockDetailVC.stockDay = stockDay
    }
    
}

extension StockViewController: UITableViewDataSource {
    
    //3
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockDaysByMonth.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //calculate average opening Prices
        let currentMonthOpeningPrices = stockDaysByMonth[section].map { (stockDay) -> Double in
            return stockDay.open
        }
        let averageOpeningPrice = Brain.averageOfNums(currentMonthOpeningPrices)
        
        //get date
        let date = stockDaysByMonth[section][0].date.components(separatedBy: "-")
        let month = Int(date[1])!
        let year = date[0]
        
        //set section title
        return "\(Brain.months[month]!) - \(year) Average: $\(averageOpeningPrice)"
    }
    
    //4
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDaysByMonth[section].count
    }
    
    //5
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //textLabel = date
        //detailTextLabel = opening price
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stockDay = stockDaysByMonth[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = stockDay.date
        cell.detailTextLabel?.text = "$\(stockDay.open)"
        
        return cell
    }
    
}
