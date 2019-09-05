//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables and Outlets
    
    var stockData: [Stock]!
    var sectionNames = [String]()
//    var matrixData = [[Stock]]()
    
    //MARK: - Stock Methods
    //This Seperates stockData by sectionName into a new array of [Stock]
    func stockBySection(sectionNumber: Int) -> [Stock] {
        return stockData.filter({$0.sectionName == sectionNames[sectionNumber]})
    }
    
    //for every stock in stockData: If sectionNames [Array of strings] does not contain selected stock.sectionName, append it to the array of sectionNames.
    func getSectionNames() {
        for stock in stockData {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }

    
    @IBOutlet weak var stockTableView: UITableView!
    
    
    
    
    //MARK: - Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySection(sectionNumber: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stockInSection = stockBySection(sectionNumber: indexPath.section)
        let currentStock = stockInSection[indexPath.row]
        cell.textLabel?.text = currentStock.date
        cell.detailTextLabel?.text = "$\(currentStock.open)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    

    

    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier in segue")
        }
        switch segueIdentifier {
        case "stockSegue":
            guard let detailVC = segue.destination as? StocksDetailVC
                else {
                    fatalError("Unexpected segue")}
            guard let selectedIndexPath = stockTableView.indexPathForSelectedRow else {
                fatalError("No row selected")
            }
            detailVC.selectedStock = stockData[selectedIndexPath.row]
            detailVC.previousStock = stockData[selectedIndexPath.row - 1]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    
    
    //MARK: - Lifecycle Methods
    private func loadStocks(){
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("Could not find bundle")
        }
        print(pathToJSONFile)
        //url is the reference of the location of the json file
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let resultsFromJSON = Stock.getStocks(from: data)
            stockData = resultsFromJSON
        } catch {
            fatalError("Could not decode")
        }
    }
    
    override func viewDidLoad() {
        stockTableView.delegate = self
        stockTableView.dataSource = self
        loadStocks()
        getSectionNames()
        super.viewDidLoad()
    }

}
