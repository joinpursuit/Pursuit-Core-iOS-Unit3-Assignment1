//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Waring on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    
var appleInfo = [AppleStockInfo]()
    var array = [[AppleStockInfo]]()
    var month = [String]()
    var average = [[Double]]()
    
    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self 
        loadData()
        for i in 0..<appleInfo.count {
            let monthYear = "\(appleInfo[i].label.components(separatedBy: " ")[0]) \(appleInfo[i].date.components(separatedBy: "-")[0])"
            if !month.contains(monthYear) {
                month.append(monthYear)
                array.append([])
                average.append([])
            }
            array[array.endIndex - 1].append(appleInfo[i])
            average[average.endIndex - 1].append(appleInfo[i].open)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = stockTableView.indexPathForSelectedRow, let cvc = segue.destination as? StockDetailViewController
            else{fatalError("indexPath CVC is nil")}
        let apple = appleInfo[indexPath.row]
        cvc.appl = apple
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
                do{
                    appleInfo = try JSONDecoder().decode([AppleStockInfo].self, from: data )
                    
                } catch {
                    print(error)
                }
            }
            
        }
        
    }
}
extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //appleInfo = appleInfo.sorted(by:{$0.date < $1.date})
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let info = array[indexPath.section][indexPath.row]
        let date = "\(info.date)"
        let open = String(format: "%.2f", info.open)//reduces the amount of numbers after decimal.
        cell.textLabel?.text = date
        cell.detailTextLabel?.text = open
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return month[section]
    }
    
    
    
    
}


    

