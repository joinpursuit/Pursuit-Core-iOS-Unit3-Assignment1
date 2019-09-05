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
        getImage()
    }
    func setUpLabels() {
        dateLabel.text = passingInfo.date
        closingLabel.text = passingInfo.close.description
        openingLabel.text = passingInfo.open.description
        view.backgroundColor = passingInfo.colorBackGroundColor()
       
    }
    func getImage() {
        if passingInfo.close > passingInfo.open {
           
                
            
            ImageHelper.shared.fetchImage(urlImage: Pictures.bullMarket) { (result) in
                switch result {
                case .failure(let error):
                    print("can't receive image \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                    self.imageViewLabel.image = image
                        
                }
                }
            }
        } else {
            
                
            
            ImageHelper.shared.fetchImage(urlImage: Pictures.bearMarket) { (result) in
                switch result {
                case .failure(let error):
                    print("can't receive image \(error)")
                
                case .success(let image):
                     DispatchQueue.main.async {
                    self.imageViewLabel.image = image
                    }
                    }
                }
            }
        }
    }


