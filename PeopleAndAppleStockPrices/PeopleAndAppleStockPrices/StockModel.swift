//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum StockJSONError: Error {
    case decodingError(Error)
}

struct StockInfo: Codable {
    
    let date: String
    let open: Double
    let close: Double
    let label: String
    
    static func getStockData(from data: Data) throws -> [StockInfo]{
        do{
            let stock = try JSONDecoder().decode([StockInfo].self, from: data)
            return stock
        } catch {
            throw UserJSONError.decodingError(error)
        }
    }
    
}



