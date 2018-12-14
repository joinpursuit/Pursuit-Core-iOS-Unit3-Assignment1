//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
     var stocksToSet: StockClass!
     //var stocksPrice: StockClass!
     var stock: StockClass!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelOpen: UILabel!
    @IBOutlet weak var labelClose: UILabel!
    @IBOutlet weak var openName: UILabel!
    @IBOutlet weak var closeName: UILabel!
    
    let stocks = ["thumbsDown","thumbsUp"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDate.text = stocksToSet.date
        labelOpen.text = stocksToSet.open.description
        labelClose.text = stocksToSet.close.description
        loadImage()
        
    }
    func loadImage() {
        if stocksToSet == nil {
            return
        }
        
        if stocksToSet.change < 0{
            view.backgroundColor = .red
           imageView.image = UIImage(named: "thumbsDown")
        } else if stocksToSet.change >= 0 {
            view.backgroundColor = .green
            imageView.image = UIImage(named: "thumbsUp")
        }
    }
}


