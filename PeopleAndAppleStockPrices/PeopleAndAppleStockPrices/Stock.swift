//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    let vwap: Double?
    let label: String
    let change: Double
}
