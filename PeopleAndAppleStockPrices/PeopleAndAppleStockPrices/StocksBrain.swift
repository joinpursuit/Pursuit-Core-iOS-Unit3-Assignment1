//
//  StocksBrain.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
  let date: String
  let open: Double
  let close: Double
  let vwap: Double
  
  func groupingStocksByMonths() {
    
    
    
  }
}


//I'll need to filter data into array of arrays (1st GOT app) - I'll need year and months (extract the info from the date )
