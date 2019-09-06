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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
