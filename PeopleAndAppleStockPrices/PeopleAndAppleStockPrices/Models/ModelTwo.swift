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
}
