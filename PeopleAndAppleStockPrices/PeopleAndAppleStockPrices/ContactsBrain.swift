//
//  ContactsBrain.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct User: Codable {
  let results: [ResultsToSet]
}
struct ResultsToSet: Codable {
  let location: Address
  let name: Name
  let email: String
  let cell: String
  let picture: Picture
}

struct Name: Codable {
  let first: String
  let last: String
  
  public var fullName: String {
    return first.capitalized + " " + last.capitalized
  }
  
}

struct Address: Codable {
  let street: String
  let city: String
  let postcode: String
  
  public var fullAddress: String {
   return street.capitalized + ", " + city.capitalized + ", " + postcode.uppercased()
  }
}

struct Picture: Codable {
  let large: URL
}


