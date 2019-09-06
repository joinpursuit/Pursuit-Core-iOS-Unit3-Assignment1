//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by 马文龙 on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockModel: Codable {
    let date: String
    let open: Double
    let close: Double
}

