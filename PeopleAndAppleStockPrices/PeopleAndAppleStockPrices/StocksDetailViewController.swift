//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    
    var stocks: Stocks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

      
    }
    
    func updateUI() {
        dateLabel.text = stocks.date
        openLabel.text = "Open: \(String(format: "%.02f", stocks.open))"
        closeLabel.text = "Close: \(String(format:"%.02f", stocks.close))"
        if stocks.open < stocks.close {
            self.view.backgroundColor = .green
            pictureImage.image = UIImage(named: "thumbsUp")
        }
        if stocks.open > stocks.close {
            self.view.backgroundColor = .red
            pictureImage.image = UIImage(named: "thumbsDown")
        }
        
        
    }



}
