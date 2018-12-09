//
//  StockSearchAPI.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

enum StockAPIError: Error {
    case badURL(String) // asscociative type
    case networkError(Error)
    case decodingError(Error)
}

final class StockSearchAPI {
    
}
