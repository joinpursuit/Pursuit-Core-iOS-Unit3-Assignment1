//
//  StringExtention.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Michelle Cueva on 8/31/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateFormat(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
}
