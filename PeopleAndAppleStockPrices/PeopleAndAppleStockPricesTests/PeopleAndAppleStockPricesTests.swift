//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

class PeopleAndAppleStockPricesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Testing we are fetching data correctly
    // See if it exists
    // See if you get number
    // Are you getting an object, an array of objects?
    func testStockDataFromFile() {
        let data = getStockDataFromJSON()
        XCTAssertNotNil(data)
    }
    
    func testStockIsAnArray() {
        guard let data = getStockDataFromJSON() else {
            XCTFail()
            return
        }
        guard let stocks = Stock.getStock(from: data) else {
            XCTFail()
            return
        }
        XCTAssert(type(of: stocks) == [Stock].self, "You do not have an array of Stock")
    }
    
    func testStockIsNotEmpty() {
        guard let data = getStockDataFromJSON() else {
            XCTFail()
            return
        }
        guard let stocks = Stock.getStock(from: data) else {
            XCTFail()
            return
        }
        XCTAssert(stocks.count > 0, "You have an empty array")
    }
    
    func testStock() {
        guard let data = getStockDataFromJSON() else {
            XCTFail()
            return
        }
        guard let stocks = Stock.getStock(from: data) else {
            XCTFail()
            return
        }
        XCTAssert(type(of: stocks[0]) == Stock.self, "You do not have Stock Objects in your array")
    }
    
    func testSortOnDate() {
        guard let data = getStockDataFromJSON() else {
            XCTFail()
            return
        }
        guard let stocks = Stock.getStock(from: data) else {
            XCTFail()
            return
        }
        
        let sortedStocks = Stock.getSortedArr(arr: stocks)
        XCTAssert(
            sortedStocks[0].date.toDate(dateFormat: "yyyy-MM-dd")! < sortedStocks[1].date.toDate(dateFormat: "yyyy-MM-dd")!, "You do not have a sorted array")
    }
    
    func testGetDateInDateFormat() {
        let dob = "1991-02-22"
        let stock = Stock(date: dob, openPrice: 1, closePrice: 1)
        let date = stock.getDateinDateFormat()
        XCTAssert(type(of: date) == Date.self, "This is not a date")
    }
    
    func testGetDateFormat() {
        let dob = "1992-02-20"
        XCTAssert(dob.toDateFormat(dateFormat: "yyyy-MM-dd") == "02/20/1992", "Did not give back correct format")
    }
    
    private func getStockDataFromJSON() -> Data? {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {return nil}
        
        let url = URL(fileURLWithPath: pathToData)
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("\(jsonError)")
        }
        
    }


}
