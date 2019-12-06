//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockData: Decodable {
    let date: String
    let open: Double
    let close: Double
    let change: Double
    let label: String
}

extension StockData {
    static func getStockData(from: Data) -> [StockData] {
        var stockData = [StockData]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            
            let stockInfo = try JSONDecoder().decode([StockData].self, from: data)
            
            stockData = stockInfo
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return stockData
    }
}

//extension UserData {
//    static func getUserData(from: Data) -> [User] {
//        var users = [User]()
//
//        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
//            fatalError("could not locate json file")
//        }
//        do {
//            let data = try Data(contentsOf: fileURL)
//
//            let userInfo = try JSONDecoder().decode(UserData.self, from: data)
//            users = userInfo.results.sorted {$0.name.first < $1.name.first}
//        } catch {
//            fatalError("failed to load contents \(error)")
//        }
//        return users
//    }
//}


//{
//   "date": "2017-08-29",
//   "uClose": 163.05,
//   "uOpen": 166.1,
//   "uHigh": 168.31,
//   "uLow": 161,
//   "uVolume": 30184771,
//   "close": 170.64,
//   "open": 164.6,
//   "high": 170.95,
//   "low": 164,
//   "volume": 30067252,
//   "change": 0,
//   "changePercent": 0,
//   "label": "Aug 29, 17",
//   "changeOverTime": 0
// },
