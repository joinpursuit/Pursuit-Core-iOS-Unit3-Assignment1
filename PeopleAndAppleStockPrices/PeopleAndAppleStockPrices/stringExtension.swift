//
//  stringExtension.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


