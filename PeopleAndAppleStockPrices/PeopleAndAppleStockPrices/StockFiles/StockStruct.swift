//
//  StockStruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit


struct AppleStockPrices: Codable {
    let label: String
    let date: String
    let open: Double
    let close: Double
    
    static func getStockData(from data: Data) throws -> [AppleStockPrices] {
        do {
            let stockData = try JSONDecoder().decode([AppleStockPrices].self, from: data)
            return stockData
        } catch {
            print(error)
            throw error
        }
    }
}
