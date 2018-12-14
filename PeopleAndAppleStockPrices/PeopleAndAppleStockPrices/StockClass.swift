//
//  StockClass.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

class StockClass {
    let date: String
    let open: Double
    let close: Double
    let vwap: Double
    let label: String
    let monthYear: String
    let change: Double
    
    init(date: String, open: Double,close: Double,vwap: Double,monthYear:String,label: String,change: Double) {
        self.date = date
        self.close = close
        self.open = open
        self.vwap = vwap
        self.label = label
        self.monthYear = monthYear
        self.change = change
    }
   
}
