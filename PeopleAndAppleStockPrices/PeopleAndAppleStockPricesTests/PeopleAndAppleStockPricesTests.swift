//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Liana Norman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

class PeopleAndAppleStockPricesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Method and one test to see if People JSON object exists
    
    private func getPeopleDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("couldn't find json file called userinfo.json")
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("couldn't find data in json file: \(jsonError)")
        }
    }
    
    func testPeopleDataLoaded() {
        let data = getPeopleDataFromJSON()
        let users = People.getUsers(from: data)
        XCTAssertTrue(users.count > 0, "No people data could be found from json file")
    }
    
    // MARK: Method and one test to see if Stocks JSON object exists
    
    private func getStocksDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError("couldn't find json file called applstockinfo.json")
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("could not find data in json file: \(jsonError)")
        }
    }
    
    func testStocksDataLoaded() {
        let data = getStocksDataFromJSON()
        let stocks = Stocks.getStocks(from: data)
        XCTAssertTrue(stocks.count > 0, "No stocks data could be found from json file")
    }

}
