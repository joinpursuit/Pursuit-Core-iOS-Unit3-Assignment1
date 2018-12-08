//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    var stocks = [StockModel]()
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stockTableView.dataSource = self
//        print(self.stocks)
        


    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.stocks = try JSONDecoder().decode([StockModel].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    

}
extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableViewCell else {fatalError("error getting stock cell")}
        let stockToSet = stocks[indexPath.row]//add section code here
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stockToSet.date)!
        let components = NSCalendar.current.dateComponents([.day, .month, .year], from: date as Date)

        print(components)
        
        
        cell.dateLabel.text = stockToSet.date
        cell.openPriceLabel.text = String(stockToSet.open)
        print(stockToSet.date)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "January"
        case 1:
            return "February"
        case 2:
            return "March"
        case 3:
            return "April"
        case 4:
            return "May"
        default:
            return "Month"
        }
    }
    
    
}
