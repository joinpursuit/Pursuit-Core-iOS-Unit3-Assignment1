//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    var date: String
    let openPrice: Double
    let closePrice: Double
    
    
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
    
    func getDateinDateFormat() -> Date {
        return self.date.toDate(dateFormat: "yyyy-MM-dd")!
    }
    
    static func getSortedArr(arr: [Stock]) -> [Stock] {
        return arr.sorted{ $0.getDateinDateFormat() < $1.getDateinDateFormat() }
    }
}
