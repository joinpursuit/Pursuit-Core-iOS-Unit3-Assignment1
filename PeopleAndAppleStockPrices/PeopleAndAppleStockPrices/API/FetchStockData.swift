//
//  FetchStockData.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 2/27/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation

class FetchStockData{

static let manager = FetchStockData()


    static func getStockData() -> Data {
            guard let pathToJSONFile = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
                fatalError()
            }

            let url = URL(fileURLWithPath: pathToJSONFile)

            do {
                let data = try Data(contentsOf: url)
                return data
            }
            catch {
                fatalError("\(error)")
            }
        }
    }
  
