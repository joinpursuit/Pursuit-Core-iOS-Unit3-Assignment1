//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
     var stocksToSet: Stocks!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelOpen: UILabel!
    @IBOutlet weak var labelClose: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
        labelDate.text = stocksToSet.date
    }
    func set() {
        
    }
}
