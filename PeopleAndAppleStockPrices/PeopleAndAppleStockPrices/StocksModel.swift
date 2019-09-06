//
//  StocksModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    
    static func getStocks(from data: Data) -> [Stocks] {
        do {
           let stocks = try JSONDecoder().decode([Stocks].self, from: data)
            return stocks
        } catch {
          fatalError("Could not decode \(error)")
        }
        
    }
}
