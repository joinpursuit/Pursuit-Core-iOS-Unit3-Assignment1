//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    var allStocks: Stocks!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()

    }


    func setUpLabel() {
        DateLabel.text = allStocks.date
        openLabel.text = "\(allStocks.open)"
        closeLabel.text = "\(allStocks.close)"
        view.backgroundColor = allStocks.changeBackgroundColor()
        pictureImage.image = allStocks.changeImage()
    }

}


