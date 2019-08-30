//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let openPrice: String
    let closePrice: String
    
    
    private enum CodingKeys: String, CodingKey {
        case date
        case openPrice = "uOpen"
        case closePrice = "uClose"
    }
    
    static func getStock(from data: Data) -> [Stock]? {
        do {
            let newStock = try JSONDecoder().decode([Stock].self, from: data)
            return newStock
        } catch {
            return nil
        }
    }
}
