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
  let location: StringToSet
  let name: StringWrapper
}
struct StringWrapper: Codable {
  let title: String
  let first: String
  let last: String
  //    let location: String
  //    let street: String
  //    let city: String
}

struct StringToSet: Codable {
  let street: String
  let city: String
}

//struct ContactsBrain: Codable{
//  let results: [ContactInfo]
//}
//
//struct ContactInfo: Codable{
//  let name: FullName
//  let email: Email
//  let phoneNumber: PhoneNumber
//  let contactPicture: Picture
//}
//
//struct FullName: Codable{
//  let first: String
//  let last: String
//
//  func getFullName() -> String {
//    let fullName = first.capitalized + " " + last.capitalized
//    return fullName
//  }
//}
//
//struct Email: Codable{
//  let email: String?
//}
//
//struct PhoneNumber: Codable{
//  let cell: String
//}
//
//struct Picture: Codable {
//    let medium: String
//}



//
//
//struct ContactsBrain: Codable {
//
//  struct ResultData: Codable {
//    let results: ContactsBrain
//  }
//
//  struct Name: Codable {
//    let first: String
//    let last: String
//
//    func getFullName() -> String {
//      let fullName = first.capitalized + " " + last.capitalized
//      return fullName
//    }
//  }
//
//  struct Picture: Codable {
//    let medium: String
//  }
//  let name: Name
//  let email: String
//  let cell: String
//  let picture: Picture
//
//}
