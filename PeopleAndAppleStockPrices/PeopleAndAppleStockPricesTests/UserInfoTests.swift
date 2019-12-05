//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Cameron Rivera on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

class UserInfoTests: XCTestCase {

    let filename = "userinfo"
    let ext = "json"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForValidURL() {
        // Arrange
        
        // Act
        let validURL = Bundle.main.url(forResource: filename, withExtension: ext)
        
        // Assert
        XCTAssertNotNil(validURL, "URL value is nil")
    }
    
    func testGetData() {
        // Arrange
        
        // Act
        let data = UserInfo.getData(from:filename, with: ext)
        
        // Assert
        XCTAssertNotNil(data,"Could not obtain data")
    }
    
    func testGetUsers(){
        // Arrange
        let data = UserInfo.getData(from: filename, with: ext)
        
        // Act
        let users = UserInfo.getUsers(using: data)
        
        // Assert
        XCTAssertGreaterThan(users.count, 0, "\(users.count) is not greater than \(0)")
    }
    
    func testUserDataIsValid() {
        // Arrange
        let data = UserInfo.getData(from: filename, with: ext)
        let users = UserInfo.getUsers(using: data)
        let expectedFirstName = "eugene"
        
        // Act
        let userFirstName = users.first?.name.first ?? "Georgina"
        
        // Assert
        XCTAssertEqual(expectedFirstName, userFirstName, "\(expectedFirstName) is not equal to \(userFirstName)")
    }
    
    func testDisplayDate(){
        // Arrange
        let data = UserInfo.getData(from: filename, with: ext)
        let users = UserInfo.getUsers(using: data)
        let expectedDate = "July 20, 1990"
        
        // Act
        let testDate = UserInfo.displayDate(date: users.first!.dob.components(separatedBy: " ").first!)
        
        // Assert
        XCTAssertEqual(testDate, expectedDate, "\(testDate) is not equal to \(expectedDate)")
    }

}
