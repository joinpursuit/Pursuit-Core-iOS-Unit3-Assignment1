//
//  ModelTwo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit


struct Stocks:Codable {
  let date: String
  let  open: Double
  let  close:Double
  let  high: Double
  let  low: Double
  let label:String
    func colorBackGroundColor() -> UIColor {
        if open > close {
            return .red
        } else {
            return .green
        }
    }
    func loadLocalImage() -> UIImage {
        var picture = UIImage()
        if open < close {
            if let bullMarket = UIImage(named: "bullmarket") {
                 picture = bullMarket
            }
            return picture
        } else
            if let bearMarket = UIImage(named:"bearmarket"){
        picture = bearMarket
        }
        return picture
    }
    
    
    }


