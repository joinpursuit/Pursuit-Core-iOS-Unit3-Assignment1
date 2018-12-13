//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    var stock: StockInformation!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var openPrice: UILabel!
    @IBOutlet weak var closePrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockDetail()
    }
    
    func stockDetail(){
        date.text = stock.date
        openPrice.text = "Open: $\( String(format: "%0.2f", stock.open))"
        closePrice.text = "Close: $\(String(format: "%0.2f", stock.close))"
        if stock.open < stock.close {
            view.backgroundColor = .green
            image.image = UIImage(named: "thumbsUp")
        } else if stock.open > stock.close {
            view.backgroundColor = .red
            image.image = UIImage(named: "thumbsDown")
        }
    }
}
