//
//  AppError.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badJsonError
    case networkError
    case noDataError
    case noResponse
    case badURL
    case badHTTPResponse
    case notFound // for 404
    case badImage
    case unauthorized // 403 and 401
    case thppppp
    case other(rawError: String)
}
