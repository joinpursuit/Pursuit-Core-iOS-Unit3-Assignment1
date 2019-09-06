//
//  PeopleAndAppleStockPricesTests.swift
//  PeopleAndAppleStockPricesTests
//
//  Created by Michelle Cueva on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

class PeopleAndAppleStockPricesTests: XCTestCase {
    
    var data: Data!
    var stocks: [Stock]!
    
    var userData: Data!
    var users: [User]!
    
    var person: Name!
    var location: Location!
    var picture: Picture!
    var user: User!
    
    override func setUp() {
        guard let jsonData = getStockDataFromJSON() else {
            XCTFail("Unable to fetch Stock Data From JSON")
            return
        }
        data = jsonData
        
        do {
            let givenStocks = try
                Stock.getStock(from: data)
            stocks = givenStocks
        } catch {
            XCTFail("Unable to fetch stocks")
            return
        }
        
        guard let UserJSONData = getUserDataFromJSON() else {
            XCTFail("Unable to fetch User Data from JSON")
            return
        }
        userData = UserJSONData
        
        do {
            let givenUsers = try
                UserWrapper.getUsers(from: userData)
            users = givenUsers
        } catch {
            XCTFail("Unable to fetch Users")
            return
        }
        
        person = Name(title: "mr", first: "mario", last: "lopez")
        location = Location(street: "166 gothic drive", city: "jamaica", state: "ny", postcode: "11432")
        picture = Picture(picture: "")
        
        user = User(name: person, email: "person@email.com", phone:"017683 99464", dob:"1945-03-14 09:49:13", location: location, picture: picture  )
    }

    override func tearDown() {
        stocks = nil
        data = nil
        
        users = nil
        userData = nil
    }
    
    func testStockDataFromFile() {
        let data = getStockDataFromJSON()
        XCTAssertNotNil(data)
    }
    
    func testStockExist() {
        XCTAssertNotNil(stocks , "You don't have Stock")
    }
    
    func testStockIsNotEmpty() {
        XCTAssert(stocks.count > 0, "You have an empty array")
    }
    
    func testStock() {
        XCTAssert(type(of: stocks[0]) == Stock.self, "You do not have Stock Objects in your array")
    }
    
    func testSortOnDate() {
        let sortedStocks = Stock.getSortedArr(arr: stocks)
        XCTAssert(
            sortedStocks[0].date.toDate(dateFormat: "yyyy-MM-dd")! < sortedStocks[1].date.toDate(dateFormat: "yyyy-MM-dd")!, "You do not have a sorted array")
    }
    
    func testGetDateInDateFormat() {
        let dob = "1991-02-22"
        let stock = Stock(date: dob, openPrice: 1, closePrice: 1)
        let date = stock.getDateinDateFormat()
        XCTAssert(type(of: date) == Date.self, "This is not a date")
    }
    
    func testGetDateFormat() {
        let dob = "1992-02-20"
        XCTAssert(dob.toDateFormatInString(dateFormat: "yyyy-MM-dd") == "02/20/1992", "Did not give back correct format")
    }
    
    func getStockDataFromJSON() -> Data? {
        guard let pathToData = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {return nil}
        
        let url = URL(fileURLWithPath: pathToData)
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("\(jsonError)")
        }
        
    }
    
    func testDateComponents() {
        let date = "2019-07-12"
        let parsedDate = Stock.getDateComponents(date: date)
        XCTAssert(parsedDate == "2019-07", "Did not parse date correctly")
    }
    
    
    func testDictionaryofGroupedStocks() {
        let DictionaryStocks = Stock.getGroupedStocks(arr: stocks)
        XCTAssertNotNil(DictionaryStocks["2019-07"])
    }
    
    func testAverageofOpenStockPrice() {
        let DictionaryStocks = Stock.getGroupedStocks(arr: stocks)
        guard let DictionaryValue = DictionaryStocks["2017-08"] else {
            XCTFail("Key does not exist")
            return
        }
        let average = Stock.getAverageForMonth(arr: DictionaryValue)
        XCTAssert(average == 167.09 , "Does not calculate average on Mothly Stocks")
    }
    

    func testUserDataFromFile() {
        let data = getUserDataFromJSON()
        XCTAssertNotNil(data)
    }
    
    private func getUserDataFromJSON() -> Data? {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: "json") else {return nil}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let jsonError {
            fatalError("\(jsonError)")
        }
        
    }
    
    func testUsersExist() {
        XCTAssertNotNil(users , "You don't have Users")
    }
    
    func testUserIsNotEmpty() {
        XCTAssert(users.count > 0, "You have an empty array")
    }
    
    func testGetsUserFullName() {
        let name = user.getFullName()
        
        XCTAssert(name == "Mr. Mario Lopez", "You have an empty array")
    }
    
    func testGetUserFullAddress() {
        let address = user.getFullAddress()
        XCTAssert(address == """
            166 Gothic Drive
            Jamaica, Ny 11432
            """, "Does not get full address")
    }
    
    func testGetSortedUsersArray() {
        let sortedUsers = User.getSortedArray(arr: users)

        XCTAssert(sortedUsers[0].getFullName() < sortedUsers[1].getFullName() , "You do not have a sorted array based on full name")
    }
    
    func testgetUserDOB() {
        let newDate = user.getDOB()
        
        XCTAssert(newDate == "03/14/1945", "You do not have the correct format for date")
    }
    
    func testgetUserPhoneNumber() {
        let newNumber = user.getPhoneNumber()
        XCTAssert(newNumber == "017683-99464", "You do not have the correct format for phoneNumber")
    }
}
