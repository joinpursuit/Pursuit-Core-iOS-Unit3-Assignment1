//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by albert coelho oliveira on 9/5/19.
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
  

        func checkUserData() {
        let userDataJson = FetchUserData.getDataFromJSON()
                let userData = UserBase.decodeUser(data: userDataJson)
                XCTAssertFalse(userData.isEmpty, "Could not load user data")
        }
    func checkStockData(){
        let stockDataJson = FetchStockData.getStockData()
        let stockData = StockWrapper.getStocks(fron: stockDataJson)
        XCTAssertTrue(stockData.isEmpty, "Could not load stock data")
    }
    
}
