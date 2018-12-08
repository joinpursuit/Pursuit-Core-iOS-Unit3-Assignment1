//
//  PeopleModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Genesis Mosquera on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

//struct People: Codable {
//    struct DisplayPeople: Codable {
//        let peopleCount: Int
//        let results: [People]
//    }
//    struct Picture: Codable {
//        let thumbnail: URL
//        let mediumImage: URL
//    }
//
//    let title: String?
//    let first: String?
//    let last: String?
//    let state: String?
//
//}

struct People: Codable {
    struct DisplayPeople: Codable {
        let peopleCount: Int
        let results: [ResultWrapper]
    }
    struct ResultWrapper: Codable {
        let gender: String
        let name: NameWrapper
        let location: LocationWrapper
    }
    
    struct NameWrapper: Codable {
        let title: String
        let first: String
        let last: String 
    }
    
    struct LocationWrapper: Codable {
        let city: String
    }
}

