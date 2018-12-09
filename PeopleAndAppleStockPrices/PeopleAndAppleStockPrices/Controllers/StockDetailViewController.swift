//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var stockChangeImg: UIImageView!
    @IBOutlet weak var openingPrice: UILabel!
    @IBOutlet weak var closingPrice: UILabel!
    
    var stockDay: StockDay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set opening price
        //set closing price
        
        
        //compare opening & closing price to set 1) img  2) background color
            //increase = green color, cat image
            //decrease = red color, bear image

    }
    
}
