//
//  StockList.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String
    
}
