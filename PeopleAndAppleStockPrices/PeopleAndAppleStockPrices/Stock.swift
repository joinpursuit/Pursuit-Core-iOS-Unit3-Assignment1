//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let label: String
    let open: Double
    let close: Double
    var stub: String {
        String(date.prefix(7))
    }
    
    static func getStocks(from data: Data) throws -> [Stock] {
        do {
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            return stocks
        }
        catch {
            throw error
        }
    }
}
