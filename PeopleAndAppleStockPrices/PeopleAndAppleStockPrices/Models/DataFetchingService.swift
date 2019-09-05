//
//  DataFetchingService.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct DataFetchingService {
    static func getUserDataFromJSON() -> Data {
        guard let pathToUserData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError()
        }
        
        let userURL = URL(fileURLWithPath: pathToUserData)
        
        do {
            let userData = try Data(contentsOf: userURL)
            return userData
        } catch {
            fatalError("\(error)")
        }
    }
    
    
}

