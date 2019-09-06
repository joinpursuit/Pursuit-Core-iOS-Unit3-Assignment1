//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var StocksTableView: UITableView!
    
    var stockInfo = [Stocks]().sorted(by: {$0.date > $1.date}) {
        didSet{
            StocksTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStockData()
        StocksTableView.dataSource = self
        //StocksTableView.delegate = self
    }
    
    func loadStockData() {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType:"json")
            else {
                fatalError("applstockinfo.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            let stocksFromJSON = try
                stockInfo = Stocks.getStocksData(data: data)
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return stockInfo.count
       return stockInfo[section].date.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return ""
        default:
            return ""
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowToSetup = indexPath.row
        let currentSection = indexPath.section
       // let dateAtRow = stockInfo[currentSection][rowToSetup]
        let cell = StocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let setupInfo = stockInfo[indexPath.row]
        cell.textLabel?.text = setupInfo.date
        cell.detailTextLabel?.text = "\(setupInfo.open)"
        return cell
    }
    
}

