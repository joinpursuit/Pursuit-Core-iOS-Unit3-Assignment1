//
//  AppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Bienbenido Angeles on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

class AppleStockPricesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfUserDataExists(){
        //Arrange
        let filename = "applstockinfo"
        let ext = "json"
        
        //Act
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        
        //Assert
        XCTAssertNotNil(data)
    }
    
    func testGetStocks(){
        //Arrange
        let filename = "applstockinfo"
        let ext = "json"
        
        //Act
        let stocks = StockInfo.getStockInfo(filename: filename, ext: ext)
        
        //Assert
        XCTAssertGreaterThan(stocks.count, 0)
    }
    
    func testConvertDateStringToString(){
        //Arrange
        let filename = "applstockinfo"
        let ext = "json"
        let stocks = StockInfo.getStockInfo(filename: filename, ext: ext)
        
        let stockDate = stocks[0].date
        let someFormatter = DateFormatter()
        someFormatter.dateFormat = "yyyy-MM-dd"
        
        let someDate = someFormatter.date(from: stockDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM - YYYY"
        
        let expectedDateString = dateFormatter.string(from: someDate ?? Date())
        
        //Act
        let convertedStockDate = stockDate.convertDateStringtoString()
        //Arrange
        XCTAssertEqual(convertedStockDate, expectedDateString)
    }
    
    func testAverageForMonth(){
        //Arrange
        let filename = "applstockinfo"
        let ext = "json"
        let stocks = StockInfo.getStockInfo(filename: filename, ext: ext)
        let expectedAverage = (stocks[0].open + stocks[1].open) / 2.0

        //Act
        let stockAverage = StockInfo.averageForMonth(section: [stocks[0], stocks[1]])

        //Assert
        XCTAssertEqual(expectedAverage, stockAverage)
    }
    
    func testIsStockGreen(){
        //Arrange
        let filename = "applstockinfo"
        let ext = "json"
        let stocks = StockInfo.getStockInfo(filename: filename, ext: ext)
        
        let stockDate = stocks[0]
        //Act
        let stockDateIsGreen = stockDate.isStockGreen()
        
        //Assert
        XCTAssertTrue(stockDateIsGreen)
    }
    
}
