//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Kevin Natera on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

class PeopleAndAppleStockPricesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    func testIfUserDataExists() {
        let data = getUserDataFromJSON()
        XCTAssertTrue(data != nil)
    }
    
    
    func testIfUserDataLoaded() {
        let data = getUserDataFromJSON()
        do {
            let users = try UserWrapper.getUserData(from: data)
            XCTAssertTrue(users.count == 200)
        } catch {
            print(error)
        }
    }
    
    func testIfStockDataExists() {
        let data = getStockDataFromJSON()
        XCTAssertTrue(data != nil)
    }
    
    
    
    
    
    
    
    
    
    
    private func getUserDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
    
    private func getStockDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else { fatalError("Couldn't find json file") }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("Couldn't get data from json file: \(jsonError)")
        }
    }
}

