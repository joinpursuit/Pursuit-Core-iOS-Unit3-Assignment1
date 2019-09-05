//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Kary Martinez on 9/5/19.
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
    
    func testDoesContactDataExist() {
        let data = getContactDataFromJson()
        XCTAssertNotNil(data, "Data Not Found")
    }
    
    func testUsersAreInArray() {
        let data = getContactDataFromJson()
        
        do {
            let users = try
                ResultsWrapper.getUser(from: data)
            XCTAssert(type(of: users) == [ResultsWrapper].self , "No array of users")
            
        } catch {
            XCTFail()
        }
        
    }
    
    func testgetFullName() {
        
        let userName = userNameWrapper(title: "miss", first: "patrick", last: "star")
       let locationName = locationWrapper(street: "", city: "", state: "")
       let pictureOfUser = pictureWrapper(large: "")
      
       let person = ResultsWrapper(name: userName, email: "", location: locationName, picture: pictureOfUser)
        
        XCTAssert(person.getFullName() == "Miss. Patrick Star", "the fuction does not give full name")

    }
    

    private func getContactDataFromJson() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            fatalError("user.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
        
    }
}

