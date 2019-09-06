//
//  ErrorHandling.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum ErrorHandling: Error {
    case badURL
    case decodingError
    case noData
    case networkError
    case badHTTPResponse
    case notFound
    case unauthorized
    case other(String)
}
