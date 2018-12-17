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
    var formattedDate: String {
        var Ddate = date
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "MMMM-yyyy"
            Ddate = dateFormatter.string(from: date)
          
        }
      return Ddate
    }
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Int
    var unadjustedVolume: Int
    var change: Double
    var changePercent: Double
    var vwap: Double
    var label: String?
    var changeOverTime: Double
 
    
    
   
     
     var stockSectionName:String {
        return formattedDate
    }

   
    
}

