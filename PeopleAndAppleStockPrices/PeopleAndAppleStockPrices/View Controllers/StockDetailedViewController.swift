//
//  StockDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailedViewController: UIViewController {
  
  var stockDetailed: Stocks!
  
  
  @IBOutlet weak var upDownImage: UIImageView!
  
  
  @IBOutlet weak var dateDetailedStock: UILabel!
  
  
  @IBOutlet weak var openPriceDetail: UILabel!
  
  
  @IBOutlet weak var closingPriceDetailed: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stockDetailedInfo()
    
  }
  
  func stockDetailedInfo() {
    upDownImage.image = UIImage.init(named: "thumbsUp")
    dateDetailedStock.text = stockDetailed.date
    openPriceDetail.text = String(stockDetailed.open)
    closingPriceDetailed.text = String(stockDetailed.close)
    
    
  }
  
  
}
