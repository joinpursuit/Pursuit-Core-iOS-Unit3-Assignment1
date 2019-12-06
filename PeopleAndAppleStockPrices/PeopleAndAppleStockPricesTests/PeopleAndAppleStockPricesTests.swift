//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Yuliia Engman on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

let filename = "userinfo"
let ext = "json"
let data = Bundle.readRawJSONData(filename: filename, ext: ext)

let afilename = "applstockinfo"
let aext = "json"
let adata = Bundle.readRawJSONData(filename: afilename, ext: aext)

class PeopleAndAppleStockPricesTests: XCTestCase {

    func testCountOfContacts() {
        // arrange
        let expectedContactsCount = 100

        // act
        let contacts = UserData.getUserData(from: data)

        // assert
        XCTAssertEqual(contacts.count, expectedContactsCount)
    }

    func testFirstNameSetup() {
        // arrange
        let firstName = UserData.getUserData(from: data).first
        let expectedName = "Adrian"

        // act
        let name = firstName?.name.first ?? "no name"

        // assert
        XCTAssertEqual(name, expectedName)


    }
}
 

extension PeopleAndAppleStockPricesTests {

   

    func testStocksCount() {
        let expectedStocks = 503

        let stocks = StockData.getStockData(from: adata)

        XCTAssertEqual(stocks.count, expectedStocks)
    }
    
    func testGettingStockData() {
        
        let firstDate = StockData.getStockData(from: adata)
        let expectedDate = "2017-08-29"
        
        let oneDate = firstDate.date.first
        
        XCTAssertEqual(gettingdate, expectedDate, "we expect to get back \(expectedDate)")
        
    }

}
