//
//  stockManager.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class stockManager {
    var stocks: [stockWrapper]
    init(stocks: [stockWrapper]) {
        self.stocks = stocks
    }
    
//    func stockAverage(year: String, month: String)-> Double{
//        let filteredStocks = stocks.filter{ (stocks) -> Bool in
//            stocks.year == year && stocks.month == month
//        }
//        return Double(filteredStocks.reduce(0, + ))/Double(filteredStocks.count)
//}
}
