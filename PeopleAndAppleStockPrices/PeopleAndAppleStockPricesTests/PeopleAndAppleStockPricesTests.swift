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
        let userDataFromJSON = DataAPIClient.getUserDataFromJSON()
        
        let userData = UserWrapper.getAllUsers(from: userDataFromJSON)
        
        XCTAssertTrue(userData != nil, "Could not load User data")
    }

    func testGetFullName() {
        let testNameWrapper = NameWrapper.init(firstName: "testFirstName", lastName: "testLastName")
        let testLocationWrapper = LocationWrapper.init(state: "testLocation")
        let testPicture = ImageWrapper.init(imageURL: "testImage")
        let testUser = User.init(name: testNameWrapper, location: testLocationWrapper, email: "testEmail", picture: testPicture)
        let actualResult = testUser.getFullName(firstName: testUser.name.firstName, lastName: testUser.name.lastName)
        
        let expectedResult = "Testfirstname Testlastname"
        
        XCTAssertTrue(actualResult == expectedResult, "Could not get full name, got: \(actualResult)")
        
    }
    
    
    func testStockDataExists() {
        let stockDataFromJSON = DataAPIClient.getStockDataFromJSON()
        
        let stockData = Stock.getAllStocks(from: stockDataFromJSON)
        
        XCTAssertTrue(stockData != nil, "Could not load Stock data")
    }
    
    func testGetDateForHeader() {
        let testStock = Stock.init(date: "2017-08-29", open: 1.0, close: 1.0)
        let actualResults = testStock.dateForHeader
        
        let expectedResults = "08/2017"
        
        XCTAssert(actualResults == expectedResults, "Could not change date for header, got: \(actualResults)")
    }
    
    func testGetAverageForMonth() {
        let stock1 = Stock.init(date: "N/A", open: 1.0, close: 0.0)
        let stock2 = Stock.init(date: "N/A", open: 2.0, close: 0.0)
        let stock3 = Stock.init(date: "N/A", open: 3.0, close: 0.0)
        let stockArr = [stock1,stock2,stock3]
        let actualResult = Stock.getAverageForMonth(stockInSection: stockArr)
        
        let expectedResult = "2.00"
        
        XCTAssert(actualResult == expectedResult, "Did not get average. Expected: \(expectedResult), got:\(actualResult)")
    }

}
