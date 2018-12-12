//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Leandro Wauters on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    var stock: Stocks!
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockDate: UILabel!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    

    func updateUI(){
        if stock.change < 0 {
            view.backgroundColor = .red
            stockImage.image = UIImage(named: "thumbsDown")
        } else if stock.change >= 0 {
            view.backgroundColor = .green
            stockImage.image = UIImage(named: "thumbsUp")
        }
        stockDate.text = stock.date
        stockOpen.text = stock.open.description
        stockClose.text = stock.close.description
        
        
    }

}
