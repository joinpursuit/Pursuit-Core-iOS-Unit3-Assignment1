//
//  PeopleModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct People: Codable {
    let results: [resultsInfo]
    
}
struct resultsInfo: Codable {
    let name: Name
    let location: Location
    let email: String
    let picture: Picture
    
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let city: String
    let state: String
}

struct Picture: Codable {
    let thumbnail: String
}

class PeopleAPIManager {
    private init() {}
    
    static let shared = PeopleAPIManager()
    
    func getPeople(completionHandler: @escaping (Result<[resultsInfo],Error>)-> Void){
        
        let urlString = "https://randomuser.me/api/?results=50"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ErrorHandling.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) {(data, _, error) in
            guard error == nil else {
                completionHandler (.failure(ErrorHandling.noData))
            return
                
            }
            guard let data = data else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            do {
                let peopleData = try
                JSONDecoder().decode(People.self, from: data)
                completionHandler(.success(peopleData.results.sorted(by: { (info1, info2) -> Bool in
                    return info1.name.first < info2.name.first
                })))
            } catch {
                completionHandler(.failure(ErrorHandling.decodingError))
            }
        }.resume()
    }
}


