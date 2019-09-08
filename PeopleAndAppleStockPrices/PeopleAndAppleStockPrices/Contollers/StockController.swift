//
//  StockController.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockController: UIViewController {
    
    var stockInfo = [StockInfo]() {
        didSet {
            stockTableView.reloadData()
        }
    }

    @IBOutlet weak var stockTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
    }
    

    private func loadData() {
        guard let pathToJSONfile =  Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
        return
        }
        let url = URL(fileURLWithPath: pathToJSONfile)
        do {
            let data = try Data(contentsOf: url)
            stockInfo = try  StockInfo.getStockInfoData(data:data)
        }
        catch {
            print (error)
        }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let indexPath = stockTableView.indexPathForSelectedRow,
                let destination = segue.destination as? DetailStockController else { return }
            
            var stockToSendOver = stockInfo[indexPath.row]
            destination.stock = stockToSendOver
        
        
        
        
        
        
        
    }
}

extension StockController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        var singlestockInfo = stockInfo[indexPath.row]
        cell.textLabel?.text =  "\(stockInfo[indexPath.row].date)"
        cell.detailTextLabel?.text = "\(stockInfo[indexPath.row].open)"
    
        
        
        return cell
    }
    
    
}

extension StockController: UITableViewDelegate {
    
}



