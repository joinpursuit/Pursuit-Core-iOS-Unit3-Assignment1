//
//  RoundDoubles.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/2/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Double {
    func roundToTwoSpaces() -> Double {
        let divisor: Double = 100
        return (self * divisor).rounded() / divisor
    }
}
