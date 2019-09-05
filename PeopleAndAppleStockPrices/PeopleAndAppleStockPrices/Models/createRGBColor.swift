//
//  createRGBColor.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct RGBValue {
    var red = Double.random(in: 0.1...0.9)
    var blue = Double.random(in: 0.1...0.9)
    var green = Double.random(in: 0.1...0.9)
    let alpha = 1.0
    
    
    func createRGBColor() -> UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha) )
}
}
