//
//  StockInfoService.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

class StockInfoService {
    static func loadData() -> [AppleStocks]{
        
        var results = [AppleStocks]()
        
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            
            let myUrl = URL.init(fileURLWithPath: path)
            
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    results = try JSONDecoder().decode([AppleStocks].self, from: data).sorted{$0.date < $1.date}
                } catch {
                    print(error)
                }
            }
        }
        return results
    }
}

