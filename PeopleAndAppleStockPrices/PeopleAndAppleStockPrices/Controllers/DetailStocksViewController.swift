//
//  DetailStocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailStocksViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockOpeningLabel: UILabel!
    @IBOutlet weak var stockClosingLabel: UILabel!
    @IBOutlet weak var thumbsUpDownImage: UIImageView!
    
    // MARK: Properties
    var stock: Stocks!
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: Private Methods
    func setUpViews() {
        stockDateLabel.text = stock.date
        stockOpeningLabel.text = stock.open.description
        stockClosingLabel.text = stock.close.description
        thumbsUpDownImage.image = stock.setImageForStockDVC()
        view.backgroundColor = stock.setBackgroundColorForStockDVC()
    }

    

}
