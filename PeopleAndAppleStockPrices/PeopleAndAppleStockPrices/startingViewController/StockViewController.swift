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
    var dateTitleSection = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        getDateTitles()
    }
    
    private func loadData(){
        let data = FetchStockData.getStockData()
        stock = StockWrapper.getStocks(fron: data)
    }
    private func getDateTitles(){
        for i in stock where !dateTitleSection.contains(i.dateForSection){
            dateTitleSection.append(i.dateForSection)
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

    func numberOfSections(in tableView: UITableView) -> Int {
           return dateTitleSection.count
       }
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return dateTitleSection[section]
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stocksInSection = stock.filter { $0.dateForSection == dateTitleSection[section]
        }
           return stocksInSection.count
       }
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
           let stocksInSection = stock.filter { $0.dateForSection == dateTitleSection[indexPath.section] }
        let stockInfo = stocksInSection[indexPath.row]
           cell.textLabel?.text = stockInfo.date
           cell.detailTextLabel?.text = stockInfo.open.description
           return cell
       }
   
   
    
}
