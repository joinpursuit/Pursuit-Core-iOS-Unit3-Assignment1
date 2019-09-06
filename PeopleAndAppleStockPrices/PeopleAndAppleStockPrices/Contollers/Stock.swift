//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    let date: String
    let open: Double
    let close: Double

    static func getStockInfoData(data: Data) throws -> [StockInfo] {
        do {
            let stockInfoData = try JSONDecoder().decode([StockInfo].self, from: data)
            return stockInfoData
        }
        catch {
            throw error
        }
    }
}

