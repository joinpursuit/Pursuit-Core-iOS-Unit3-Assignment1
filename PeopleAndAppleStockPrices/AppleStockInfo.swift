//
//  AppleStockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Waring on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct AppleStockInfo: Codable{
    let date: String
    let open: Double
    let close: Double
    let label: String
}
