//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct Stock: Codable {
    var date: String
    var open: Double
    var close: Double
    var label: String
    var high: Double
    var low: Double
    
    
    
    static func getStocks(from data: Data) -> [Stock] {
        do {
            let stockInfo = try JSONDecoder().decode([Stock].self, from: data)
            return stockInfo
        } catch let decodeError {
            fatalError("could not decode info \(decodeError)")
        }
}

    
    
    

}




