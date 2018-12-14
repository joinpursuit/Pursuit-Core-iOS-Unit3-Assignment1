//
//  ApplesView.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ApplesView: UIViewController {
    
    var appleInformation = [appleStocks]()
    
    @IBOutlet weak var applesTableView: UITableView!
    
    var myMatrix = [[appleStocks]]()
    
    var mySections = [String]()
    
    var months = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applesTableView.dataSource = self
        applesTableView.delegate = self
        dump(myMatrix)
        appleloadData()        
        
        for i in 1...12 {
            for number in months  {
                let filterArray = appleInformation.filter{$0.date.components(separatedBy: "-")[1] == "\(number)"}
                myMatrix.append(filterArray)
            }
        }
    }
    
    func appleloadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let appleUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: appleUrl) {
                do {
                    var something = try JSONDecoder().decode([appleStocks].self, from: data)
                    self.appleInformation = something
                    self.appleInformation.sort{$0.date < $1.date}
                
                    
                    
                } catch {
                    print("my error \(error)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destination = segue.destination as? appleDetailController,
       let cellSelected = applesTableView.indexPathForSelectedRow else {return}
       let appleinfo = appleInformation[cellSelected.row]
        destination.appleDetailView = appleinfo
    }
    
}
extension ApplesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  myMatrix[section].count
        print(myMatrix)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applesTableView.dequeueReusableCell(withIdentifier: "stocks")
        let cellSelcted = myMatrix[indexPath.section][indexPath.row]
        cell?.textLabel?.text = cellSelcted.date
        cell?.detailTextLabel?.text = "\(String(format: "%.2f", cellSelcted.close))"
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return myMatrix.count
    }
}
extension ApplesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "January"
        case 1:
            return "February"
        case 2:
            return "March"
        case 3:
            return "April"
        case 4:
            return "May"
        case 5:
            return "June"
        case 6:
            return "July"
        case 7:
            return "August"
        case 8 :
            return "September"
        case 9 :
            return "October"
        case 10 :
            return "Novemeber"
        case 11 :
            return "December"
        default :
            return "Not Here"

        }
    
    }
    
}
