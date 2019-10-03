//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Krystal Campbell on 9/6/19.
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
    private func getStockDataFromJSON() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType:"json")
            else {
                fatalError("applstockinfo.json file not found")
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        }catch let jsonError {
            fatalError("could not find file: \(jsonError)")
        }
        
    }
    
    func testStockDataLoad() {
        let data = getStockDataFromJSON()
        do {
        let stocks = try Stocks.getStocksData(data: data)
        XCTAssertTrue(stocks.count > 0, "no data mon")
        }catch{
            print(error)
            
        }
    }
}



