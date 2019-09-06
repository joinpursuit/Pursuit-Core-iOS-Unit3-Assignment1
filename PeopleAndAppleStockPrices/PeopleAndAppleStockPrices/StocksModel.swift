//
//  StocksModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    
    static func getStocks(from data: Data) -> [Stocks] {
        do {
           let stocks = try JSONDecoder().decode([Stocks].self, from: data)
            return stocks
        } catch {
          fatalError("Could not decode \(error)")
        }
        
    }
    
    func setImageForStockDVC() -> UIImage {
        if open > close {
            return UIImage(named: "thumbsUp")!
        } else {
            return UIImage(named: "thumbsDown")!
        }
    }
    
    func setBackgroundColorForStockDVC() -> UIColor {
        if open > close {
            return UIColor.green
        } else {
            return UIColor.red
        }
    }
}
