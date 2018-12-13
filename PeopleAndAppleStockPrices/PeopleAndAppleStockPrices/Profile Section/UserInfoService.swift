//
//  UserInfoService.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

class UserInfoService {

   static func loadData() -> [User] {
        
        var results = [User]()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            
            let myUrl = URL.init(fileURLWithPath: path)
            
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    let newPeople = try JSONDecoder().decode(Profile.self, from: data)
                    results = newPeople.results.sorted { $0.name.first < $1.name.first }
                } catch {
                    print(error)
                }
            }
        }
        return results
    }

}
