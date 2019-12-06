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
    
    
//    static func classificationSections() -> [StockData] {
//        // Skip step 1 since our stock data already sorted
//        var newArrayOfDate = [String]()
//        var sectionArray = [String]()
//        // 2. we want to know how many unique classification we have - basically how many new month we have
//        // so we can use Set to identify how many unique classifications we have - but before we have to remove date first
//        
//        let filename = "applstockinfo"
//        let ext  = "json"
//        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
//        let stocks = getStockData(from: data)
//        let uniqueSections = Set(stocks.map {$0.date})
//        
//        
//        var updatedDate = stocks.first?.date.components(separatedBy: "-")
//        updatedDate?.popLast()
//        let newString = updatedDate
//        
//         
//        if     == newString {
//            
//        }
//        
//        return
//        
//    }
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
