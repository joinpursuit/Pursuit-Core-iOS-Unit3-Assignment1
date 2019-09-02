//
//  StockViewController.swift
//  Unit3_Real
//
//  Created by EricM on 9/2/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var stockTableViewOutlet: UITableView!
    var stocks = [Stock](){
        didSet {
            stockTableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableViewOutlet.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let shares = stocks[indexPath.row]
        cell.textLabel?.text = shares.date
        cell.detailTextLabel?.text = "volume: \(shares.volume) \(shares.open)"
        return cell
        
    }
    
    private func loadData() {
        //pathToJSONFile is just the string for the name of the file
        guard let pathToJSONFile = Bundle.main.path(forResource: "applestockinfo", ofType: "json") else {
            fatalError("Could not find bundle")
        }
        print(pathToJSONFile)
        //url is the reference of the location of the json file
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let resultsFromJSON = Stock.getStock(from: data)
            stocks = resultsFromJSON
            
        } catch {
            fatalError("Could not decode")
        }
    }
    //test
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableViewOutlet.dataSource = self
        stockTableViewOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    

    

}
