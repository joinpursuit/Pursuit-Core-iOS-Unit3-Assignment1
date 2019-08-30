//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Levi Davis on 8/30/19.
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

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoadContacts() {
        let data = getContactDataFromJSON()
        let contacts = Results.getContacts(from: data)
        XCTAssertTrue(contacts != nil, "There is no contact here")
    }
    
    func testContactsHasTwoHundredElements() {
        let data = getContactDataFromJSON()
        let contacts = Results.getContacts(from: data)
        XCTAssertTrue(contacts.count == 200, "There are \(contacts.count) contacts here")
    }
    
    func testStockHasFiveHundredThreeElements() {
        let data = getStockDataFromJSON()
        let stocks = Stock.getPrices(from: data)
        XCTAssertTrue(stocks.count == 503, "There are \(stocks.count) stocks here")
    }
    
    private func getContactDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError("Could not find path")}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("Error: \(jsonError)")
        }
    }
    
    private func getStockDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError("Could not fund path")}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("Error: \(jsonError)")
        }
    }

}
