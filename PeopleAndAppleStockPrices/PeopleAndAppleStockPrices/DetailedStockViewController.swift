//
//  DetailedStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ramu on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class DetailedStockViewController: UIViewController {
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockTitle: UILabel!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockClose: UILabel!
    
    
    var stock: AppleStockData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()

        
    }
    func configureData() {
        self.stockTitle?.text = stock.date
        self.stockOpen?.text = "Open: $\(stock.open)"
        self.stockClose?.text = "Close: $\(stock.close)"
        if stock.open > stock.close {
            self.stockImage?.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            self.stockImage?.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red
        }

}
}
