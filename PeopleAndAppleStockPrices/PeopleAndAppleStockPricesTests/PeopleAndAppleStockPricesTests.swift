//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Radharani Ribas-Valongo on 10/7/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

@testable import PeopleAndAppleStockPrices

class PeopleAndAppleStockPricesTests: XCTestCase {

    func testGetstocks() {
        let stocks = StockInfo.getStocks()
        XCTAssert(stocks.count > 0, "we got stocks: \(stocks.count)")
    }
    
    func testGetUsers() {
        let users = User.getUser()
        XCTAssert(users.count > 0 , "we got users: \(users.count)")
    }

}
