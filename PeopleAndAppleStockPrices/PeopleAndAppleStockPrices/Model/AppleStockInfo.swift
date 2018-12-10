//
//  AppleStockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Biron Su on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

class AppleStockInfo: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String
}
