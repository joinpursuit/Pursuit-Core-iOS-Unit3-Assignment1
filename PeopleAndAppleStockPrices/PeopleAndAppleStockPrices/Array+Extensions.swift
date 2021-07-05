//
//  Array+Extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Bienbenido Angeles on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Array where Element: Comparable{
    func isSorted() -> Bool {
        guard self.count > 1 else{
            return true
        }
        
        for i in 1..<self.count {
            if self[i] > self[i-1]{
                return false
            }
        }
        return true
    }
}

