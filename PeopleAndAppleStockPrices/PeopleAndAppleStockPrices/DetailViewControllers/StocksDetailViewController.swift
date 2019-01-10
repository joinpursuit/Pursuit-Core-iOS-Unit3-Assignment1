//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    
    @IBOutlet weak var stocksImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var close: UILabel!
    @IBOutlet weak var open: UILabel!
    
    var stock : StockData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    
    }
    
    func setUpUI(){
        date.text = stock.date
        close.text = "\(stock.close)"
        open.text = "\(stock.open)"
        if stock.close > stock.open {
            view.backgroundColor = .green
            stocksImage.image = UIImage(named: "thumbsUp")
        }else {
            view.backgroundColor = .red
            stocksImage.image = UIImage(named: "thumbsDown")
        }
    }

   
}
