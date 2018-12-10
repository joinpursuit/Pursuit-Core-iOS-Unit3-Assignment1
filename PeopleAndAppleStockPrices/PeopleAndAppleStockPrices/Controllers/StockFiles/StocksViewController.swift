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
//    var emptyStocks = [[]]
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stockTableView.dataSource = self
//        stocks = Array(repeating: [StockModel](), count: 25)//25 months need to change from hard code

        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stockTableView.indexPathForSelectedRow,
        let stocksDetailViewController = segue.destination as? StocksDetailViewController else {return}
        let stock = stocks[indexPath.row]
        stocksDetailViewController.stockSelected = stock
    }
    
    func dateFormat(indexPath: IndexPath) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stocks[indexPath.row].date)!
        let components = NSCalendar.current.dateComponents([.day, .month, .year], from: date as Date)
        // https://stackoverflow.com/questions/45080312/cannot-invoke-value-of-type-nscalendar-unit-type-with-argument-list-rawvalue
        //https://stackoverflow.com/questions/36861732/swift-convert-string-to-date
        print(components.year!)
        print(components.month!)
//        var years = [Int]()
//        years += components.year!
//        print(years)
//        emptyStocks = Array(repeating: [StockModel](), count: 25)//25 months need to change from hard code
//        stocks = emptyStocks
//        print(emptyStocks)
        //for each year/month make a new array in our array
        
//        components.year.map {$0 == $1 }
    }
    
    func loadData() {
//        self.stocks.forEach {
//            var date = $0.date
//            let index = date.index(date.startIndex, offsetBy: 0)
//            print(index)
//            $0.date; print("hello \($0.date)")}
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
        dateFormat(indexPath: indexPath)
        let stockToSet = stocks[indexPath.row]//add section code here
        
        cell.dateLabel.text = stockToSet.date
        cell.openPriceLabel.text = String(format: "%.2f", stockToSet.open)
        print(stockToSet.date)
        return cell
    }
    func numberOfSections(in tableView: UITableView, indexPath: IndexPath) -> Int { //if you don't need the date stuff here remove ", indexPath: IndexPath"
//        dateFormat(indexPath: indexPath)
//
        return stocks.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "December"
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        default:
            return "Month"
        }
    }
    
    
}
