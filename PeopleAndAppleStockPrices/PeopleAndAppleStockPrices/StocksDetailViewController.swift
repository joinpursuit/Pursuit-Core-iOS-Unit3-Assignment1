//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {

    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    @IBOutlet weak var stockDate: UILabel!
    var aStock: Stock!
    func setupView() {
        if aStock.close < aStock.open {
            view.backgroundColor = .green
            stockImage.image = UIImage.init(named: "thumbsUp")
        } else {
            view.backgroundColor = .red
            stockImage.image = UIImage.init(named: "thumbsDown")
        }
        stockDate.text = "\(aStock.date)"
        stockOpen.text = "\(String(format: "%.2f", aStock.open))"
        stockClose.text = "\(String(format: "%.2f", aStock.close))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    

    
}
