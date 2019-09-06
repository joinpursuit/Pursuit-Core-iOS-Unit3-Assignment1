//
//  Unit3_RealTests.swift
//  Unit3_RealTests
//
//  Created by EricM on 9/2/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import XCTest
@testable import Unit3_Real

class Unit3_RealTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func getDataFromJSON(name: String) -> Data {
        guard let pathToData = Bundle.main.path(forResource: name , ofType: "json") else { fatalError("couldnt find json file called \(name).json")}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("couldnt get data from json file \(jsonError)")
        }
    }

    /// testing for stuff
    func testPeopleLoaded (){
        let data = getDataFromJSON(name: "userinfo")
        let testPeople = PeopleWrapper.getPeople(from: data).results
        XCTAssertTrue(testPeople.self != nil, "user info failed to load")
    }
    
    func testAppleLoaded (){
        let data = getDataFromJSON(name: "applestockInfo")
        let testStock = Stock.getStock(from: data)
        XCTAssertTrue(testStock.self != nil, "apple stock failed to load")
    }
    
    
    
    
    
    
    
    
    
    
}
