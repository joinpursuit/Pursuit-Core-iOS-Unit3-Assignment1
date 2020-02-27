//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
 var stock = [StockWrapper]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("coundn't find json file")}
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try
                Data(contentsOf: url)
            let stockJson = try StockWrapper.getStocks(fron: data)
            stock = stockJson
        }
        catch {
            print(error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockVC = segue.destination as? StockDetailViewController else {
            fatalError("Unexpected segue")
        }
        guard let selectedIndexPath = tableView.indexPathForSelectedRow
            else { fatalError("No row selected") }
        stockVC.stock = stock[selectedIndexPath.row]
    }
}
extension StockViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = stock[indexPath.row].date
        cell.detailTextLabel?.text = stock[indexPath.row].open.description

        return cell
    }
   
    
}
