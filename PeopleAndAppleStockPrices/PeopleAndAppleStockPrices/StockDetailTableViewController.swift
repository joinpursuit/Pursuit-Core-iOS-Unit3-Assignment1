//
//  StockDetailTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailTableViewController: UIViewController {
    
    var stockDetailInfo: StockInfo!
    

    
    
    
    
    @IBOutlet weak var stockDetailedImage: UIImageView!
    
    @IBOutlet weak var stockDetailDate: UILabel!
    
    @IBOutlet weak var stockDetailOpen: UILabel!
    
    @IBOutlet weak var stockDetailClose: UILabel!
    
    @IBOutlet var stockDetailBckView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockDetailDate.text = "Date: \(stockDetailInfo.date)"
        stockDetailOpen.text = "Open: \(stockDetailInfo.open)"
        stockDetailClose.text = "Close: \(stockDetailInfo.close)"
        stockDetailBckView.backgroundColor = getStockColor()
        stockDetailedImage.image = getStockImage()
        

    }
   
    func getStockColor () -> UIColor {
        if stockDetailInfo.open > stockDetailInfo.close {
            return UIColor.green
        }else{
            return.red
        }
    }
    
    func getStockImage () -> UIImage {
        if stockDetailInfo.open > stockDetailInfo.close {
            return UIImage(named: "thumbsUp")!
        }else{
            return UIImage(named: "thumbsDown")!
        }
    }
    

   

}
