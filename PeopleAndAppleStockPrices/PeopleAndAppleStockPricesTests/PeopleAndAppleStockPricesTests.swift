//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Liana Norman on 9/4/19.
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
    
    private func getPeopleDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("couldn't find json file called userinfo.json")
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("couldn't find data in json file: \(jsonError)")
        }
    }
    
    func testPeopleDataLoaded() {
        let data = getPeopleDataFromJSON()
        let users = People.getUsers(from: data)
        XCTAssertTrue(users.results.count > 0, "No data could be found from json file")
    }
    

}
