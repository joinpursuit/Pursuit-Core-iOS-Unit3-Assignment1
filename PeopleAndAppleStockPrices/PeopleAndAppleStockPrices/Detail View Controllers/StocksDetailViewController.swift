//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    
    var stock: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var stocksView: UIImageView!
    
    @IBOutlet weak var openPriceLabel: UILabel!
    
    @IBOutlet weak var closePriceLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setBackground()
    }
    
    private func setLabels() {
        dateLabel.text = stock.getDateInStringFormat()
        openPriceLabel.text = stock.openPrice.description
        closePriceLabel.text = stock.closePrice.description
        setImage()
    }
    
    private func setImage() {
        let image =  stock.openPrice < stock.closePrice ? "thumbsUp" : "thumbsDown"
        stocksView.image = UIImage(named:image)
    }
    
    private func setBackground() {
        let color = stock.openPrice < stock.closePrice ? UIColor.green : UIColor.red
        self.view.backgroundColor = color
    }
    
}
