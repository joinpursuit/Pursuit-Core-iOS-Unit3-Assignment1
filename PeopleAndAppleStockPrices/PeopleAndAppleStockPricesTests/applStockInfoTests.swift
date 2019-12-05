//
//  applStockInfoTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Cameron Rivera on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import PeopleAndAppleStockPrices

class applStockInfoTests: XCTestCase {

    let filename = "applstockinfo"
    let ext = "json"
    
    func testGetValidURL(){
        // Arrange
        
        // Act
        let fileURL = Bundle.main.url(forResource: filename, withExtension: ext)
        
        // Assert
        XCTAssertNotNil(fileURL, "Could not find URL")
    }
    
    func testGetValidData() {
        // Arrange
        
        // Act
        let data = ApplStockInfo.getData(using: filename, with: ext)
        
        // Assert
        XCTAssertNotNil(data, "Could not find data")
    }
    
    func testGetStockInfo() {
        // Arrange
        let data = ApplStockInfo.getData(using: filename, with: ext)
        
        // Act
        let stockInfo = ApplStockInfo.getStockInfo(from: data)
        
        // Assert
        XCTAssertGreaterThan(stockInfo.count, 0, "\(stockInfo.count) is not greater than \(0).")
    }
    
    func testIsDataValid() {
        // Arrange
        let data = ApplStockInfo.getData(using: filename, with: ext)
        let expectedVolume = 30067252
        
        
        // Act
        let stockInfo = ApplStockInfo.getStockInfo(from: data)
        
        // Assert
        XCTAssertEqual(expectedVolume, stockInfo.first?.volume, "\(expectedVolume) is not equal to \(stockInfo.first!.volume)")
        
    }
    
    
}
