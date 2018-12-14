//
//  Contact.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pritesh Nadiadhara on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInformation: Codable {
    struct OuterLayer : Codable {
        let StockInfo: StockInformation
    }
    let date: String
    let open: Double
    let close: Double
    let vwap: Double
    let label: String
}
