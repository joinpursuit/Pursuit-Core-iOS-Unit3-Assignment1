//
//  StockTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var stocks = [Stock]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var groupedStocks: [(key: String, value: [Stock])] {
        let dict = Dictionary(grouping: stocks) {$0.stub}
        return dict.sorted{ $0.key < $1.key }
    }
    
    private var groupedStocksKey: [String] {
        groupedStocks.map{$0.key}
    }
    
    private var groupedStocksValues: [[Stock]] {
        groupedStocks.map{$0.value}
    }
    
//    var groupedStocksValues: [[Stock]] {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        print(stocks.count)
        print(groupedStocks.count)
        print(groupedStocksValues.forEach{print($0.count)})
//        print(groupedStocksKey)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StockDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            destination.stock = groupedStocksValues[indexPath.section][indexPath.row]
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: ".json") else {
            fatalError("Error ocurred trying to find file.")
        }
        let internalURL = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: internalURL)
            let stocks = try Stock.getStocks(from: data)
            self.stocks = stocks
        } catch {
            print("Error occured during decoding: \(error)")
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension StockTableViewController: UITableViewDelegate {}
extension StockTableViewController: UITableViewDataSource {
    
    // MARK: - TODO: Implement Tableview.
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedStocksKey[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedStocks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedStocksValues[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        cell.textLabel?.text = groupedStocksValues[indexPath.section][indexPath.row].date
        
        cell.detailTextLabel?.text = String(format: "$ %.2f", groupedStocksValues[indexPath.section][indexPath.row].open)
        return cell
    }
    
    
}
