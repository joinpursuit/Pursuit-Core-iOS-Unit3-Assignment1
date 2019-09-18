//
//  StocksModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct Stocks: Codable {
    let date: String
    let open: Double
    let close: Double
    
    var day: String {
       return date.components(separatedBy:"-")[2]
    }
    var month: String {
        return date.components(separatedBy:"-")[1]
    }
    var year: String {
       return  date.components(separatedBy:"-")[0]
    }
    

 func changeBackgroundColor() -> UIColor {
        if open < close {
            return UIColor.green
        } else {
            return UIColor.red
        }
    }
    
    func changeImage() -> UIImage {
        if open < close {
            return UIImage(named: "thumbsUp")!
        } else {
            return UIImage(named: "thumbsDown")!
        }
    }
    
    enum JSONError: Error {
        case decodingError(Error)
    }
        
    static func getStocksData(data:Data) throws -> [Stocks]{
        do {
            let stockData = try JSONDecoder().decode([Stocks].self, from: data)
            return stockData
        }catch{
            throw JSONError.decodingError(error)
        }
    
    }
    
}

