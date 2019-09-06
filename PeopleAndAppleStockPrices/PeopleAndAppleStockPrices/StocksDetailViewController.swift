//
//  StocksDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var info : Stocks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if info.close > info.open{
            imageView.image = UIImage.init(named: "thumbsUp")
            view.backgroundColor = .green
        }else{
            imageView.image = UIImage.init(named: "thumbsDown")
            view.backgroundColor = .red
        }
        
        dateLabel.text = "Date: \(info.date)"
        openLabel.text = "Open: \(info.open)"
        closeLabel.text = "Close: \(info.close)"
        
    }
}
