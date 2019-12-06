//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Liubov Kaper  on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices
let filename = "userinfo"
let ext  = "json"

class PeopleAndAppleStockPricesTests: XCTestCase {

    func testHowManyUsers() {
        let expectedCount = 200
        
        let user = User.getUserInfo(from: getRawData())
        
        XCTAssertEqual(expectedCount, user.count)
    }
    
    func testFirstNameFirstUserSorted() {
        let firstUser = getUsers().first
        let expectedFirstName = "abbie"
        
        let firstName = firstUser?.name.first ?? "luba"
        
        XCTAssertEqual(expectedFirstName, firstName)
    }
    


}

extension PeopleAndAppleStockPricesTests {
    
    func getRawData() -> Data {
        let data = Bundle.readRawJSONData(filename: filename, ext: ext)
        return data
    }
    
    func getUsers() -> [UserDetails] {
        let data = getRawData()
        let users = User.getUserInfo(from: data)
        return users 
    }
}
