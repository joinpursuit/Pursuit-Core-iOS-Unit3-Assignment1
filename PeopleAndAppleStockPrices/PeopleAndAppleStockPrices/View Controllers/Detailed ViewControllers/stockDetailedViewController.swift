//
//  stockDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kary Martinez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stockDetailedViewController: UIViewController {
    
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var UPLabel: UILabel!
    
    @IBOutlet weak var stockImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var currentStockinfo: Stock!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = currentStockinfo.date
        Colors()
        thumbsUpOrThumbsDownImage()
        UPLabel.text = "Open: \(currentStockinfo.uOpen)"
        downLabel.text = "Close: \(currentStockinfo.uClose)"
        
    }
    private func thumbsUpOrThumbsDownImage() {
        if currentStockinfo.uOpen < currentStockinfo.uClose {
            stockImage.image = UIImage(named: "thumbsUp")
        } else {
            stockImage.image = UIImage(named: "thumbsDown")
        }
    }
    private func Colors() {
        if currentStockinfo.uOpen <
            currentStockinfo.uClose{
            self.view.backgroundColor = UIColor.green
        }else {
            self.view.backgroundColor = UIColor.red
        }
    }

}
