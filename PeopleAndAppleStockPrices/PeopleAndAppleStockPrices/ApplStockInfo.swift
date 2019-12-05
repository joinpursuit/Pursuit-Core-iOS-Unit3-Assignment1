//
//  ApplStockInfo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Cameron Rivera on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ApplStockInfo: Decodable{
    //MARK: Properties
    var date: String
    var open: Double
    var close: Double
    var label: String
    var volume: Int
}

extension ApplStockInfo{
    // MARK: Type Methods
    static func getData(using file: String, with ext: String) -> Data{
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: ext) else {
            fatalError("Could not find a valid url.")
        }
        var data = Data()
        
        do{
            data = try Data.init(contentsOf: fileURL)
        }catch {
            print("Encountered Error: \(error)")
        }
        
        return data
    }
    
    static func getStockInfo(from data: Data) -> [ApplStockInfo]{
        var stockInfo = [ApplStockInfo]()
        
        do{
            stockInfo = try JSONDecoder().decode([ApplStockInfo].self, from: data)
        } catch {
            print("Encountered Error: \(error)")
        }
        
        return stockInfo
    }
    
    static func getAllStockInfo() -> [ApplStockInfo]{
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("Could not find a valid url.")
        }
        var data = Data()
        var stockInfo = [ApplStockInfo]()
        
        do{
            data = try Data.init(contentsOf: fileURL)
            stockInfo = try JSONDecoder().decode([ApplStockInfo].self, from: data)
            
        }catch {
            print("Encountered Error: \(error)")
        }
        return stockInfo
    }
    
    static func makeMeADate(using date: String) -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withDashSeparatorInDate,
                                          .withFullDate]
        guard let returnDate = isoDateFormatter.date(from: date) else {
            return Date()
        }
        return returnDate
    }
    
    static func makeMeAStringFromDate(using date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        return dateFormatter.string(from: date)
    }
    
    static func makeMeAStringFromDateWithDay(using date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        return dateFormatter.string(from: date)
    }
    
    static func returnStockMatrix() -> [[ApplStockInfo]] {
        let allData = ApplStockInfo.getAllStockInfo()
        let allSections = allData.map{ApplStockInfo.makeMeADate(using: $0.date)}.sorted{$0 < $1}.map{ApplStockInfo.makeMeAStringFromDate(using:$0)}
        let numberOfSections = Set<String>(allSections)
        var theMatrix = Array(repeating: [ApplStockInfo](), count: numberOfSections.count)
        
        var currentIndex = 0
        var currentSection = allSections.first!
        
        for element in allData{
            if ApplStockInfo.makeMeAStringFromDate(using: ApplStockInfo.makeMeADate(using: element.date)) == currentSection {
                theMatrix[currentIndex].append(element)
            } else {
                currentIndex += 1
                currentSection = ApplStockInfo.makeMeAStringFromDate(using: ApplStockInfo.makeMeADate(using: element.date))
                theMatrix[currentIndex].append(element)
            }
        }
        
       return theMatrix
        
    }
    
    static func calculateAverage(of opening: [ApplStockInfo]) -> Double {
        return opening.reduce(0.0){$0 + $1.open}/Double(opening.count)
    }
    
    // MARK: Other Methods
    func didMarketProfit() -> Bool {
        if self.close > self.open{
            return true
        } else {
            return false
        }
    }
    
}

