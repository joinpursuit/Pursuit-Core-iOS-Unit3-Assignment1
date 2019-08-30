//
//  PriceViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController {
    
    var stocks = [Stock]() {
        didSet {
            priceTableView.reloadData()
        }
    }

    @IBOutlet weak var priceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTableView.delegate = self
        priceTableView.dataSource = self
        loadData()
    }
    

    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError("Could not find path")}
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let stocksFromJSON = Stock.getPrices(from: data)
            stocks = stocksFromJSON
        } catch let loadDataError {
            fatalError("Error: \(loadDataError)")
        }
    }

}

extension PriceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath)
        let oneStock = stocks[indexPath.row]
        cell.textLabel?.text = oneStock.date
        cell.detailTextLabel?.text = "\(oneStock.close)"
        return cell
    }
    
}
