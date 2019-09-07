//
//  ErrorHandler.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
enum errorHandler:Error {
    case badURL
    case noDataAvailable
    case couldNotProcessData
    case badJSONError
    case networkError
    case noDataError
    case noReponse
    case notFound //404 status code
    case unathorized //403 and 401 status code
    case other(rawError:String)
    case AppError
    case badHTTPResponse
    case badImage
    
    
}
