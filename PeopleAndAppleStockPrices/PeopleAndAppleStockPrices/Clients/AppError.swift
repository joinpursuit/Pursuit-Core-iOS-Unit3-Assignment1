//
//  ErrorHandler.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case badURL
    case couldNotParseJSON
    case noImage
    case noInternetConnection
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)

}
