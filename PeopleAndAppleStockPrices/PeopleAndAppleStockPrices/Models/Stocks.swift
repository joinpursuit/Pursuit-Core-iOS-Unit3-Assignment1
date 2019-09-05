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
    
    
    }
struct Pictures {
   static let bullMarket = "https://business.nasdaq.com/media/AdobeStock_217094122_tcm5044-69163.jpeg"
    static let bearMarket = "https://pbs.twimg.com/media/C5tEEC1U8AARFjI.jpg"
}

