//
//  stocksStruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct appleStocks:Decodable {
    let date: String
    let open: Double
    let low: Double
    let close: Double
    let label: String
}
