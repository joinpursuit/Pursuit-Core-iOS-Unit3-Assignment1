//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var stockTableView: UITableView!
    
    var stockData = [StockInfo](){
        didSet{
            stockTableView.reloadData()
        }
    }
    
//    var sectionNames = [String]()
//    
//    func sortBySection(sectionNumber: Int) -> [AppleStockPrices] {
//        return prices.filter({$0.sectionName == sectionNames[sectionNumber]})
//    }
//    
//    func getSectionNames() {
//        for i in prices {
//            if !sectionNames.contains(i.sectionName) {
//                sectionNames.append(i.sectionName)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.delegate = self
        stockTableView.dataSource = self
        loadData()
    
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else{
            fatalError("Unexpected Error: couldnt find json file")
        }
        let url = URL(fileURLWithPath: pathToJSONFile)
        do{
            let data = try Data (contentsOf: url)
            self.stockData = try StockInfo.getStockData(from: data)
        }catch{
            fatalError("Unexpected Error")
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else{
            fatalError("Unexpected Error: No identifier in segue")
        }
        
        switch segueIdentifier {
        case "stockMainToDetailSegue":
            guard let stockDetailVC = segue.destination as? StockDetailTableViewController else{
                fatalError("Unexpected Error: No VC")
            }
            guard let selectedIndexPath = self.stockTableView.indexPathForSelectedRow else{
                fatalError("Unexpected Error: ")
            }
            stockDetailVC.stockDetailInfo = stockData[selectedIndexPath.row]
        default:
            fatalError("Unexpected Error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockInfo = stockData[indexPath.row]
        let stockCell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        stockCell.textLabel?.text = stockInfo.date
        stockCell.detailTextLabel?.text = "\(stockInfo.open)"
        return stockCell
    }

}
