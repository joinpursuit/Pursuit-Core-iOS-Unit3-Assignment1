//
//  stockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct stockInfo: Codable {
    let date: String
    let stockPrice: Double
    let open: Double
    let close: Double
    
    private enum CodingKeys: String, CodingKey {
        case date
        case stockPrice = "high"
        case open
        case close
    }
    
    static func getStocks(from data: Data) throws -> [stockInfo] {
        do {
            let stock = try JSONDecoder().decode([stockInfo].self, from: data)
            return stock
        } catch {
            throw ErrorHandling.decodingError
        }
    }
    
}

