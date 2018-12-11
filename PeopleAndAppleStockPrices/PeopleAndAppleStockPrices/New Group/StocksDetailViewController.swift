//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jane Zhu on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    @IBOutlet weak var stocksDateLabel: UILabel!
    
    @IBOutlet weak var stocksImage: UIImageView!
    @IBOutlet weak var stocksOpeningLabel: UILabel!
    @IBOutlet weak var stocksClosingLabel: UILabel!
    
    var stock: Stocks!

    override func viewDidLoad() {
        super.viewDidLoad()
        stocksDateLabel.text = stock.date
        stocksOpeningLabel.text = "Open: $" + String(format: "%.2f", stock.open)
        stocksClosingLabel.text = "Close: $" + String(format: "%.2f", stock.close)
        if stock.close - stock.open >= 0 {
            stocksImage.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            stocksImage.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red
        }
    }
}
