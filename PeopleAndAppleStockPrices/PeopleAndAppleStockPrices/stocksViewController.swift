//
//  stocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kary Martinez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stocksViewController: UITableViewController { //This is a UITableViewController, NOT a UIViewController.
    //UITableViewDataSource and UITableViewDelegate are already BUILT IN to a UITableViewController. So changing the methods means you have to OVERRIDE the already built-in functionality.
    
    var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentStock = stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell")
        cell?.textLabel?.text = currentStock.date
        return cell!
        
    }
    
    private func loadData () {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("appStockinfo.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            let stockinfoFromJSON = try Stock.getStock(from: data)
            stocks = stockinfoFromJSON
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
        
    }
}
