//
//  StockInfoModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct StockInformation: Codable {
    var date: String
    var open: Int
    var high: Int
    var low: Int
    var close: Int
    var volume: Int
    var unadjustedVolume: Int
    var change: Int
    var changePercent: Int
    var vwap: Int
    var label: String
    var changeOverTime: String
}
