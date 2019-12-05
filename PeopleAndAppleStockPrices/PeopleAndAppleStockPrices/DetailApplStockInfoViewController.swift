//
//  DetailApplStockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Cameron Rivera on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailApplStockInfoViewController: UIViewController{
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var closePriceLabel: UILabel!
    
    // MARK: Properties
    var currentStockInfo: ApplStockInfo?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad(){
        setUp()
        super.viewDidLoad()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        guard let unwrappedStockInfo = currentStockInfo else {
            return
        }
        dateLabel.text = ApplStockInfo.makeMeAStringFromDateWithDay(using: ApplStockInfo.makeMeADate(using: unwrappedStockInfo.date))
        openPriceLabel.text = "Open: \(String(format: "%.2f", unwrappedStockInfo.open))"
        closePriceLabel.text = "Close: \(String(format: "%.2f", unwrappedStockInfo.close))"
        
        if unwrappedStockInfo.didMarketProfit(){
            imageView.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            imageView.image = UIImage(named:"thumbsDown")
            view.backgroundColor = .red
        }
    }
}
