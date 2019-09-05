//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
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

    func testUserDataExists() {
        let userDataFromJSON = DataFetchingService.getUserDataFromJSON()
        
        let userData = UserWrapper.getAllUsers(from: userDataFromJSON)
        
        XCTAssertTrue(userData != nil, "Could not load User data")
    }

}
