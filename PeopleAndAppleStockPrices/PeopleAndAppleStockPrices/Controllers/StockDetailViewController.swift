//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    
    var stock: Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        loadImage()
    }
    
    private func configureLabels() {
        dateLabel.text = stock.date
        openLabel.text = String(format: "%.2f", stock.open)
        closeLabel.text = String(format: "%.2f", stock.close)
    }
    
    //TODO: Download images and add to assets folder
    private func loadImage() {
//        stockImage.image = UIImage(named: <#T##String#>)

    }

    private func updateBackgroundColor() {
        if stock.didStockProfit(open: stock.open, close: stock.close) {
            self.view.backgroundColor = UIColor.green
        } else {
            self.view.backgroundColor = UIColor.red
        }
    }
}
