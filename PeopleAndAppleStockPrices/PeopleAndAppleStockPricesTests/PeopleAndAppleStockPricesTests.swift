//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Michelle Cueva on 8/30/19.
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

    func testStock() {
        let data = getStockDataFromJSON()
        guard let stock = Stock.getStock(from: data) else {return}
        XCTAssert(stock != nil, "Does not exist")
    }
    
    private func getStockDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {fatalError("did not find path")}
        
        let url = URL(fileURLWithPath: pathToData)
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("\(jsonError)")
        }
        
    }


}
