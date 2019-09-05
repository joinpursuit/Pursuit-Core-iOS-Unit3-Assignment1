//
//  ErrorHandling.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum ErrorHandling: Error {
    case badURL
    case decodingError
    case noData
}
