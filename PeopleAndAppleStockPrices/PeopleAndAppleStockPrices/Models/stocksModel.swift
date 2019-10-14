//
//  stocksModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kary Martinez on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation



struct Stock: Codable {
    let date: String
    let uOpen: Double
    let uClose: Double
    var day: String {
        return date.components(separatedBy: "-")[2]
    }
    var month: String {
        return date.components(separatedBy: "-")[1]
    }
    var year: String {
        return date.components(separatedBy: "-")[0]
    }
    
    
    
    
    static func getStock(from data: Data) throws -> [Stock] {
        do {
            let stockResult = try JSONDecoder().decode([Stock].self, from: data)
            return stockResult
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}
