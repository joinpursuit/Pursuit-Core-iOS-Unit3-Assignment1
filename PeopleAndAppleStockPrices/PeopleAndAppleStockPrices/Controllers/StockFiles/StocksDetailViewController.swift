//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet var viewColor: UIView!
    
    public var stockSelected: StockModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStock()

    }
    private func updateStock() {
        guard let stockSelected = stockSelected else {fatalError("stock is nil")}
        dateLabel.text = stockSelected.date
        openLabel.text = String(format: "$%.2f", stockSelected.open)
        closedLabel.text = String(format: "$%.2f", stockSelected.close)
        if stockSelected.open >= stockSelected.close {
            viewColor.backgroundColor = UIColor.red
            stockImage.image = UIImage(named: "thumbsDown")!
        } else {
            viewColor.backgroundColor = UIColor.green
            stockImage.image = UIImage(named: "thumbsUp")!


        }        
    }

}
