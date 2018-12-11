//
//  StockAPIAgent.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


enum AppError {
    case badPath(String)
    case badData(String)
    case badDecoding(Error)
}

struct StockAPIAgent {
    //1
    static func getAllStocks(completionHandler: (@escaping ([StockDay]?, AppError?) -> Void)) {
        
        //get path(String) with guard let
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            completionHandler(nil, .badPath("Path Not Found"))
            return
        }
        
        //convert to URL and turn it into data
        guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else {
            completionHandler(nil, .badData("Can't Get Data"))
            return
        }
        
        do {
            let stockDays = try JSONDecoder().decode([StockDay].self, from: data)
            completionHandler(stockDays, nil)
        } catch {
            completionHandler(nil, .badDecoding(error))
        }
        
        //???Why this doesn't work
//                guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else {
//                    print("Bad URL")
//                    return
//                }
        //
        //        do {
        //            self.stockDays = try JSONDecoder().decode([StockDay].self, from: data)
        //        } catch {
        //            print(error)
        //        }
    }
}
