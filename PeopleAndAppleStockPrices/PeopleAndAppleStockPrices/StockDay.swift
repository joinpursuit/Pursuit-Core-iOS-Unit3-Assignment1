//
//  StockDay.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockDay: Codable {
    let date: String
    let open: Double
    let close: Double
}
