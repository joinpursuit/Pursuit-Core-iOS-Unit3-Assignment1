//
//  UserAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct UserAPIClient {
    static var shared = UserAPIClient()
    let userURL = "https://randomuser.me/api/?results=50"
    func fetchData(completionHandler:@escaping (Result<RandomUsers,Error>) -> ()) {
        guard let url = URL(string: userURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completionHandler(.failure(err))
            }
            guard let retrieveData = data else {fatalError(String(describing: error))}
            do {
                let randomUser = try JSONDecoder().decode(RandomUsers.self, from: retrieveData)
                completionHandler(.success(randomUser))
            } catch let JSONError {
                completionHandler(.failure(JSONError))
            }
        }.resume()

}
}
