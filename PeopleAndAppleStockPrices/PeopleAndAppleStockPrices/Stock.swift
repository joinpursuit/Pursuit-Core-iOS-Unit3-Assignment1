//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Rifkin on 9/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let opening: Double
    let closing: Double
    
    private enum CodingKeys: String, CodingKey {
        case date
        case opening = "open"
        case closing = "close"
    }

    static func getStocks() -> [Stock] {
        
        guard let fileName = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            return stocks
        } catch {
            fatalError()
        }
    }
}
