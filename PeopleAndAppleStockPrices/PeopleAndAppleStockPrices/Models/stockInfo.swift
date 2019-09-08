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
    
    private enum CodingKeys: String, CodingKey {
        case date
        case stockPrice = "high"
    }
    
    static func getStocks(from data: Data) throws -> [stockInfo] {
        do {
            let stock = try JSONDecoder().decode([stockInfo].self, from: data)
            return stock
        } catch {
            throw ErrorHandling.decodingError
        }
    }
    
    
    /// Trying to figure out how to filter the data from JSON to create table view categories
    
//    func decodeStocks() {
//        guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: ".json") else {
//            print("Error finding JSON file")
//            return
//        }
//
//        let url =  URL(fileURLWithPath: pathToJSONFile)
//
//        do {
//            let data = try Data(contentsOf: url)
//        } catch {
//            print("could not decode data")
//        }
//    }
//    
//    static let seventeen = stockInfo.getStocks(from: data)
    
}

