//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView!
    
    var stocks = [StockDay]()
    var stocksByMonth = [[StockDay]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        
        loadData()
        //2
        //filter StockDay by Months and append to the stocksByMonth Matrix
    }
    
    //1
    func loadData() {
        //get path(String) with guard let
        //convert to URL and turn it into data in guard let (URL error)
            //do
                //decode json
                //set stocks array
            //catch
                //decode error
    }
    
    //6
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //indexpath
        //storyboard
        
        //set backbutton
            //initiate navigation bar button
            //change the title
            //change the button title by refering to the navigation back button
        
        //get the stock I need with indexPath
        //set the stock for next page
    }
    
}

extension StockViewController: UITableViewDataSource {
    
    //3
    func numberOfSections(in tableView: UITableView) -> Int {
        //set the number of section based on the number of months (arrs) in the matrix
        //calculate average for each month (openings)
            //use brain to calculate average
        //set title name here (June - 2018 Average: $100.88)
        return 1
    }
    
    //4
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //based on the num of elements in each arr in the matrix
        return 10
    }
    
    //5
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //declare a cell variable using dequeReusableCell
        //textLabel = date
        //detailTextLabel = opening price
        return UITableViewCell()
    }
    
}
