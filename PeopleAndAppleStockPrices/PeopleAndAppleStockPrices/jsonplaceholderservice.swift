//
//  jsonplaceholderservice.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
    case post
}

struct Post: Codable {
    
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct Todo: Codable {
    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
}

@available(iOS 13.0, *)
struct okwhatever {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    private var cancellable: AnyCancellable?
    
    var cancellabe1 = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        .map{ $0.data }
        .decode(type: [Post].self, decoder: JSONDecoder())
    .replaceError(with: [])
    .eraseToAnyPublisher()
        .sink { (posts) in
            print(posts.count)
    }
}
