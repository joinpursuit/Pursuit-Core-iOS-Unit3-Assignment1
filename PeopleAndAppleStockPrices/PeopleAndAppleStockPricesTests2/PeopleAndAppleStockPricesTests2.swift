//
//  PeopleAndAppleStockPricesTests2.swift
//  PeopleAndAppleStockPricesTests2
//
//  Created by albert coelho oliveira on 2/27/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import XCTest

class PeopleAndAppleStockPricesTests2: XCTestCase {



    func testCheckUserData() {
        let userDataJson = FetchUserData.getDataFromJSON()
        let userData = UserBase.decodeUser(data: userDataJson)
        XCTAssertFalse(userData.isEmpty, "Could not load user data")
        }
    func testCheckStockData(){
        let stockDataJson = FetchStockData.getStockData()
        let stockData = StockWrapper.getStocks(fron: stockDataJson)
        XCTAssertFalse(stockData.isEmpty, "Could not load stock data")
    }
    

}
