//
//  ErrorHandler.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum ErrorHandler: Error {
    case badURL
    case decodingError
    case noData
}
