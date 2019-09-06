//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class StockDetailViewController: UIViewController {
    var price: AppleStockPrices!
    
    @IBOutlet weak var thumbImageOutlet: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openingLabel: UILabel!
    @IBOutlet weak var closingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        if price.open <= price.close {
        thumbImageOutlet.image = UIImage(named: "thumbsUp")
            view.backgroundColor = UIColor.green
        } else {
            thumbImageOutlet.image = UIImage(named: "thumbsDown")
            view.backgroundColor = UIColor.red
        }
        dateLabel.text = price.date
        openingLabel.text = "Opening Price: \(price.open) USD"
        closingLabel.text = "Closing Price: \(price.close) USD"
}
}
