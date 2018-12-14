//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Genesis Mosquera on 12/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct Stock: Codable {
    let date: String
    let open: Double
    let close: Double
    var sectionName: String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        return "\(monthDict[month]!) \(year)"
    }
    private let monthDict = ["01": "January", "02": "February", "03": "March", "04": "April","05": "May", "06": "June", "07": "July", "08": "August", "09":"September", "10": "October", "11": "November", "12": "December"]

}
