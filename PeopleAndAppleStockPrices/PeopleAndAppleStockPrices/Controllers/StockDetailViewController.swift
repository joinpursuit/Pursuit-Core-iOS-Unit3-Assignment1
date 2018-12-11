//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var stockChangeImg: UIImageView!
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var openingPrice: UILabel!
    @IBOutlet weak var closingPrice: UILabel!
    
    var stockDay: StockDay!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openingPrice.text = "Open: $\(String(format: "%.2f", stockDay.open))"
        closingPrice.text = "Close: $\(String(format: "%.2f", stockDay.close))"
        stockDate.text = stockDay.date
        
        if stockDay.close > stockDay.open {
            stockChangeImg.image = UIImage.init(named: "catThumbsUp")
            self.view.backgroundColor = .green
        } else {
            self.view.backgroundColor = .red
            stockChangeImg.image = UIImage.init(named: "bearThumbsDown")
        }
    }
    
}
