//
//  DataFetchingService.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct DataAPIClient {
    static func getUserDataFromJSON() -> Data {
        guard let pathToUserData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError()
        }
        
        let userURL = URL(fileURLWithPath: pathToUserData)
        
        do {
            let userData = try Data(contentsOf: userURL)
            return userData
        } catch {
            fatalError("\(error)")
        }
    }
    
    static func getStockDataFromJSON() -> Data {
        guard let pathToStockData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError()
        }
        
        let stockURL = URL(fileURLWithPath: pathToStockData)
        
        do {
            let stockData = try Data(contentsOf: stockURL)
            return stockData
        } catch {
            fatalError("\(error)")
        }
    }
}

