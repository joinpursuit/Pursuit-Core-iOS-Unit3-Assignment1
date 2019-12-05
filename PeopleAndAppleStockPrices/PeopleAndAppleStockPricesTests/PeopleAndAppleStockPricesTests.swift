//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Yuliia Engman on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

let filename = "userinfo"
let ext = "json"
let data = Bundle.readRawJSONData(filename: "userinfo", ext: "json")

class PeopleAndAppleStockPricesTests: XCTestCase {

    func testCountOfContacts() {
        // arrange
        let expectedContactsCount = 100
        
        // act
        let contacts = UserData.getUserData(from: data)
        
        // assert
        XCTAssertEqual(contacts.count, expectedContactsCount)
    }
    
    func testFirstNameSetup() {
        // arrange
        let firstName = UserData.getUserData(from: data).first
        let expectedName = "Adrian"
        
        // act
        let name = firstName?.name.first ?? "no name"
        
        // assert
        XCTAssertEqual(name, expectedName)
        
        
    }
  

}
