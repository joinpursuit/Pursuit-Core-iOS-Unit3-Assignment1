//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Bienbenido Angeles on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

class PeopleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfUserDataExists(){
        //Arrange
        let filename = "userinfo"
        let ext = "json"
        
        //Act
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        
        //Assert
        XCTAssertNotNil(data)
        
    }
    
    func testGetUsers() {
        //Arrange
        let filename = "userinfo"
        let ext = "json"
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        
        //Act
        let users = User.getUsers(from: data)
        //Assert
        XCTAssertGreaterThan(users.count, 0)
    }
    
    func testcapitalizeFirstLetter(){
        //Arrange
        var string = "abc"
        let expectedString = "Abc"
        
        //Act
        string.capitalizeFirstLetter()
        
        //Assert
        XCTAssertEqual(expectedString, string.capitalizingFirstLetter())
    }
    
    func testReturnFullName(){
        //Arrange
        let filename = "userinfo"
        let ext = "json"
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        let users = User.getUsers(from: data)
        var firstName = users[0].name.first
        var lastName = users[0].name.last
        firstName.capitalizeFirstLetter()
        lastName.capitalizeFirstLetter()
        let expectedFullName = firstName + " " + lastName
        //Act
        let fullName = users[0].name.returnFullName()
        //Assert
        //dump(sortedUsers.isSorted())
        XCTAssertEqual(fullName, expectedFullName)
    }

}

