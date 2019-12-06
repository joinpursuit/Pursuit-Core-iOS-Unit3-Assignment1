//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Bienbenido Angeles on 12/3/19.
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
    
    func testGetUsersSorted(){
        //Arrange
        let filename = "userinfo"
        let ext = "json"
        let data = Bundle.readRawjSONData(filename: filename, ext: ext)
        let users = User.getUsers(from: data)
        //Act
        let sortedUsers = users.sorted{$0.name.first < $1.name.first}
        //Assert
        //dump(sortedUsers.isSorted())
        XCTAssertTrue(sortedUsers.isSorted())
    }

}

