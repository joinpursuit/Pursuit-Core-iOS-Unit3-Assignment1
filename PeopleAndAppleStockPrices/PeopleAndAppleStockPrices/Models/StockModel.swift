//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockModel: Codable {
    let date: String
    let open: Double
    let close: Double
}

