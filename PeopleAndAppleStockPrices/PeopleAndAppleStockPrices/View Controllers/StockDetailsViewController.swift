//
//  StockDetailsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailsViewController: UIViewController {
    
    //MARK: -- Properties
    var stockForDate: StockPrice!
    
    //MARK: -- IBOutlets
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openingLabel: UILabel!
    @IBOutlet weak var closingLabel: UILabel!
    @IBOutlet weak var opPriceLabel: UILabel!
    @IBOutlet weak var edPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        setUpLabels()
        setVisuals()
    }
    
    private func setUpLabels() {
        dateLabel.text = "\(stockForDate.date!)"
        openingLabel.text = "$\(stockForDate.open!)"
        closingLabel.text = "$\(stockForDate.close!)"
    }
    
    private func setVisuals() {
        if stockForDate.close! >= stockForDate.open! {
            stockImageView.image = UIImage(named: "thumbsUp")
            self.view.backgroundColor = UIColor.green
            changeTextColor(color: UIColor.black)
        } else {
            stockImageView.image = UIImage(named: "thumbsDown")
            self.view.backgroundColor = UIColor.red
            changeTextColor(color: UIColor.white)
        }
    }
    
    private func changeTextColor(color: UIColor) {
        dateLabel.textColor = color
        opPriceLabel.textColor = color
        edPriceLabel.textColor = color
        openingLabel.textColor = color
        closingLabel.textColor = color
    }
    
}
