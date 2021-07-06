//
//  StockModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct StockData: Decodable {
    let date: String
    let open: Double
    let close: Double
    let change: Double
    let label: String
}

extension StockData {
    
    static func getStockData(from: Data) -> [StockData] {
        var stockData = [StockData]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            
            let stockInfo = try JSONDecoder().decode([StockData].self, from: data)
            
            stockData = stockInfo
        } catch {
            fatalError("failed to load contents \(error)")
        }
        return stockData
    }
    
    static func monthSections() -> [[StockData]] {
        // 1. we will sort dates ascending
        // our date are sorted already, therefore we can skip this step?
        // probably in this step we have to loop through our dates and remove last elements
        
        let filename = "applstockinfo"
        let ext  = "json"
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        let stocks = getStockData(from: data)
        let uniqueSections = Set(stocks.map {$0.date})
        
        var arrayOfDateWithoutDay = [String]()
        
        for date in uniqueSections {
            var updatedDate = date.components(separatedBy: "-")
            updatedDate.removeLast()
            let newUpdatedDate = updatedDate.joined(separator: " ")
            arrayOfDateWithoutDay.append(newUpdatedDate)
        }
        
        var sections = Array(repeating: [StockData](), count: uniqueSections.count)
        // arrayOfDateWithoutDay = arrayOfDateWithoutDay.sorted()
        
        var currentIndex = 0
        var sectionIndex = 0
        var currentStock = arrayOfDateWithoutDay[currentIndex]
        
        for stock in stocks {
            var theDate = stock.date.components(separatedBy: "-")
            theDate.removeLast()
            let dateWithNewFormat = theDate.joined(separator: " ")
            if dateWithNewFormat == currentStock {
                sections[currentIndex].append(stock)
            } else {
                currentStock = dateWithNewFormat
                currentIndex += 1
                sectionIndex += 1
                sections[currentIndex].append(stock)
            }
        }
        return sections
    }
}


//
//static func classificationSections() -> [[ZooAnimal]] {
//    // 1. we will sort ZooAnimals ascending:
//    let sortedZooAnimals = zooAnimals.sorted {$0.classification < $1.classification}
//
//    // 2. we want to know how many unique classification we have
//    // we will use Set to identify classification:
//    let uniqueClassifications = Set(sortedZooAnimals.map { $0.classification})
//
//    // 3. we have enough info to create an array of empty arrays:
//    // we will create an empty array of [ZooAnimal]'s array
//    var sections = Array(repeating: [ZooAnimal](), count: uniqueClassifications.count) // [[ZooAnimal], [ZooAnimal], [ZooAnimal]...]
//
//    // 4. create an initial starting index for hte sections
//    var currentIndex = 0 // 0 is our first array
//
//    // 5. get current classification name
//    var currentClassification = sortedZooAnimals.first?.classification ?? "Pursuit Dog"
//
//    // 6. loop over sortedZooAnimals and place in appropriate section
//    for animal in sortedZooAnimals {
//        if animal.classification == currentClassification {
//            sections[currentIndex].append(animal)
//        } else {
//            currentIndex += 1
//            currentClassification = animal.classification
//            sections[currentIndex].append(animal)
//        }
//    }
//    return sections
//}
