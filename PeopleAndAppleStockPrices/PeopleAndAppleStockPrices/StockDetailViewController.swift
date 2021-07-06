//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var openStockLabel: UILabel!
    @IBOutlet weak var closedStockLabel: UILabel!
    
    var someStock: StockData?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let oneStock = someStock else {
            fatalError("coule not get object from prepare for segue")
        }
        
        dateLabel.text = oneStock.label
        openStockLabel.text = String(oneStock.open)
        closedStockLabel.text = String(oneStock.close)
        
        if oneStock.close > oneStock.open {
            image.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            image.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red
        }
    }
}

