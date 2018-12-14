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

//let stockPrice1 = StockPrice(date: "2016-10-09", open: 145.0, close: 145.50)
//let stockPrice2 = StockPrice(date: "2016-10-10", open: 145.0, close: 145.50)
//let stockPrice3 = StockPrice(date: "2016-11-12", open: 145.0, close: 145.50)
//let stockPrice4 = StockPrice(date: "2016-11-13", open: 145.0, close: 145.50)
//let stockPrice5 = StockPrice(date: "2016-12-20", open: 145.0, close: 145.50)
//let stockPrice6 = StockPrice(date: "2016-12-21", open: 145.0, close: 145.50)
//let stockPrice7 = StockPrice(date: "2017-01-04", open: 145.0, close: 145.50)
//let stockPrice8 = StockPrice(date: "2017-01-05", open: 145.0, close: 145.50)
//
//func getDateMonth(dateString: String) -> (month: String, year: String) {
//    let components = dateString.components(separatedBy: "-")
//    return (components[1], components[0])
//}
//
//// 1. get all stocks parsed from the JSON file
//let allPrices = [stockPrice1, stockPrice2, stockPrice3, stockPrice4,
//                 stockPrice5, stockPrice6, stockPrice7, stockPrice8]
//
//// 2. create a 2d array of Stock Prices [[StockPrice]]()
//var stockPrices = [[StockPrice]]()

// 3. as you iterate through all stock prices from step 1. put into array buckets

// 4. create an initial empty array inside 2d array before entering loop from step 3.
//stockPrices.append([StockPrice]())
//
//// create a variable previousData
//var previousDate = ""

// create initial start index
//var startIndex = 0
//for stockPrice in allPrices {
//    let dateMonth = getDateMonth(dateString: stockPrice.date)
//    let currentDate = dateMonth.month + "-" + dateMonth.year
//    if previousDate.isEmpty { previousDate = dateMonth.month + "-" + dateMonth.year }
//
//    if currentDate != previousDate {
//        // new bucket
//        stockPrices.append([StockPrice]())
//
//        // increment startIndex
//        startIndex += 1
//    }
//    stockPrices[startIndex].append(stockPrice)
//    previousDate = dateMonth.month + "-" + dateMonth.year
//}
//
//// keep track of current month, year of stock price
//// e.g if previous stock price date is (month, year) 10, 2016
//// and current stock price is (month, year) 11, 2016
//// then append a new array to your 2d array
//// increment the start index of the 2d array
//
//// at this point you should have your 2d array of Stock Prices
//print(stockPrices.count)
