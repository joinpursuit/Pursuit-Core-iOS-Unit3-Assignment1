//
//  DetailViewControllerTwo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerStocks:UIViewController {
   
    var passingInfo:Stocks!
    
    
    
    @IBOutlet weak var imageViewLabel: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var closingLabel: UILabel!
    @IBOutlet weak var openingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
     
    }
    func setUpLabels() {
        dateLabel.text = "Date : \(passingInfo.date)"
        closingLabel.text = "Closing : \(passingInfo.close.description)"
        openingLabel.text = "Opening : \(passingInfo.open.description)"
        view.backgroundColor = passingInfo.colorBackGroundColor()
       imageViewLabel.image = passingInfo.loadLocalImage()
    }
    

    }


