//
//  Stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let stock: StockPrice?
}

struct StockPrice: Codable {
    let date: String?
    let open: Double?
    let close: Double?
    let changePercent: Double?
}
