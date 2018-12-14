//
//  PeopleSearchAPI.swift
//  PeopleAndAppleStockPrices
//
//  Created by Genesis Mosquera on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

enum PeopleAPIError: Error {
    case badUrl(String)
    case networkError(Error)
    case decodingError(Error)
}


//final class PeopleSearchAPI {
//    static func search(keyword: String, completion: @escaping (PeopleAPIError?, [People]?) -> Void) {
//        let urlString 
//    }
//    
//}
