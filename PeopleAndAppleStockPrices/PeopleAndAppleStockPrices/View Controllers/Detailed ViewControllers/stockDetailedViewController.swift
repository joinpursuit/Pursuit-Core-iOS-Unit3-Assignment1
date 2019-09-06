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
    
    var currentStockinfo: Stock!
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbsUpOrThumbsDownImage()
        UPLabel.text = "\(currentStockinfo.uOpen)"
        downLabel.text = "\(currentStockinfo.uClose)"
        
    }
    private func thumbsUpOrThumbsDownImage() {
        if currentStockinfo.uOpen < currentStockinfo.uClose {
            stockImage.image = UIImage(named: "thumbsUp")
        } else {
            stockImage.image = UIImage(named: "thumbsDown")
        }
    }


}
