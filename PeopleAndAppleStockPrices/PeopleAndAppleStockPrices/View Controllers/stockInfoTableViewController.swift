//
//  stockInfoTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stockInfoTableViewController: UITableViewController {

    
    var stocks = [stockInfo]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: ".json") else {
            print("Error finding JSON file")
            return
        }
        
        let url =  URL(fileURLWithPath: pathToJSONFile)
        
        do {
            let data = try Data(contentsOf: url)
            let stocksFromJSON = try stockInfo.getStocks(from: data)
            stocks = stocksFromJSON
        } catch {
            print("could not decode data")
        }
    }
        
    

    // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return stocks.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let stockStuff = stocks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
            cell.textLabel?.text = stockStuff.date
            cell.detailTextLabel?.text = stockStuff.stockPrice.description
            // Configure the cell...
            
            return cell
        }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = segue.destination as? StocksDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
        location.stocks = stocks[indexPath.row]
    }
    
}
