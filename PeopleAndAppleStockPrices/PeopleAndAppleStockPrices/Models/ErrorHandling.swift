//
//  ErrorHandling.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum ErrorHandling: Error {
    case badURLError
    case decodingError
    case noDataError
    case noImageError
    case other(String)
}
