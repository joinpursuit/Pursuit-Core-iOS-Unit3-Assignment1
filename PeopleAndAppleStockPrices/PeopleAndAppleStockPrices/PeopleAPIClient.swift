//
//  PeopleAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct PeopleAPIClient {
    static func getPeople() -> [Person] {
        guard let pathInString = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            print("path not found")
            return []
        }
        let urlObject = URL.init(fileURLWithPath: pathInString)
        
        if let data = try? Data.init(contentsOf: urlObject) {
            do {
                let peopleSearchData = try JSONDecoder().decode(Person.searchData.self, from: data)
                let allPeopleSorted = peopleSearchData.results.sorted { (person1, person2) -> Bool in
                    return person1.name.first < person2.name.first}
                return allPeopleSorted
            } catch {
                print(error)
                return []
            }
        } else {
            print("Can't Get Data")
            return []
        }
    }
}
