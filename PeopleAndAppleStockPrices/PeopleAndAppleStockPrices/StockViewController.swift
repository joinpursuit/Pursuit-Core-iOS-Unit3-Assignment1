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
    @IBOutlet weak var stockTableView: UITableView!
    
    
    
    
    //MARK: - Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentStock = stockData[indexPath.row]
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = currentStock.date
        cell.detailTextLabel?.text = "$\(currentStock.open)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//            case
//        }
//    }
    
    
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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
