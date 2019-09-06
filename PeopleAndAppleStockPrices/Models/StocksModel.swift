//
//  StocksModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    
    enum JSONError: Error {
        case decodingError(Error)
    }
    static func getStocksData(data:Data) throws -> [Stocks]{
        do {
            let stockData = try JSONDecoder().decode([Stocks].self, from: data)
            return stockData
        }catch{
            throw JSONError.decodingError(error)
        }
    
    }
}
