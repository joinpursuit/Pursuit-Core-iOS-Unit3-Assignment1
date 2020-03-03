//
//  stockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockWrapper: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String
    let changePercent: Double
    
    static func getStocks(fron data: Data) -> [StockWrapper]{
        do {
            let stock = try
                JSONDecoder().decode([StockWrapper].self, from: data)
            return stock
        } catch let decodeError {
            fatalError("could not decode info\(decodeError)")
    }
    }
    
    var month: String {get {
            let arr = label.components(separatedBy: " ")
            return arr[0]}}
    var year: String{get {
            let arr = label.components(separatedBy: " ")
            return arr[2]}
    }
    var dateForSection: String {get{
        return "\(month), 20\(year)"
        }
    }
}
