//
//  DetailStocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class DetailStocksViewController: UIViewController {
    var stocksView: AppleStocks!
    @IBOutlet weak var appleImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel?.text = stocksView.date
        openLabel?.text = String(format: "%.2f",stocksView.open)
        closeLabel?.text = String(format: "%.2f",stocksView.close)
        getImageAndChangeColor()
    }
    func getImageAndChangeColor(){
        if stocksView.close > stocksView.open {
            self.view.backgroundColor = .green
            appleImage.image = UIImage.init(named: "thumbsUp")
        } else {
            self.view.backgroundColor = .red
            appleImage.image = UIImage.init(named: "thumbsDown")
        }
    }


}
