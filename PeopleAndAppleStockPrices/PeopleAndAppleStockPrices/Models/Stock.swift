//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let open: Double
    let close: Double
    
    var dateForHeader: String {
        var dateArr = date.components(separatedBy: "-")
        let year = dateArr[0]
        let month = dateArr[1]
        return "\(month)/\(year)"
    }
    
    static func getAllStocks(from JSONData: Data ) -> [Stock]? {
        do {
            let allStocks = try JSONDecoder().decode([Stock]?.self, from: JSONData)
            return allStocks
        } catch {
            return nil
        }
    }
    
}
