//
//  Bundle&Extension.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

// this reads JSAN data
extension Bundle {
    //static func = class func
    static func readRawJSONData(filename: String, ext: String) -> Data {
        
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            fatalError("resourse with filename \(filename) not found")
        }
        var data: Data!
        do {
            data = try Data.init(contentsOf: fileURL)
        } catch {
            fatalError("contents not found error: \(error)")
        }
        return data
    }
}
