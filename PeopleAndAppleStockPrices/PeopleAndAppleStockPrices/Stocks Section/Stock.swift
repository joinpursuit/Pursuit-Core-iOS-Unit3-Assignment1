//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct AppleStockInfo: Codable {
    let appleStocksInfo: [AppleStocks]
}

struct AppleStocks: Codable {
    let date: String
    let open: Double
    let close: Double
    let change: Double
}
