//
//  stockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct stockWrapper: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String
    let changePercent: Double
    
    
    static func getStocks(fron data: Data) -> [stockWrapper]{
        do {
            let stock = try
                JSONDecoder().decode([stockWrapper].self, from: data)
            return stock
        } catch let decodeError {
            fatalError("could not decode info\(decodeError)")
    }
    }
    var month: String {get {
            let arr = date.components(separatedBy: "-")
            return arr[1]}}
    var year: String{get {
            let arr = date.components(separatedBy: "-")
            return arr[0]}}
    
}
