//
//  combinepractice.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//
import Foundation
import Combine

@available(iOS 13.0, *)
struct NetworkAgent {
    
    static let shared = NetworkAgent()
    private init() {}
    // carries a parsed value and a url response instance, latter can be used for status code validation and logging
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    //single entry point for requests execution.  accepts a url request; decoder is optional in case custon JSON parsing is needed.
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // creates data task as combine publisher
            .tryMap { (result) -> Response<T> in
                //parses json data, contrains T to decodable.
                let value = try JSONDecoder().decode(T.self, from: result.data)
                // creates response obnject and url response
                return Response(value: value, response: result.response)
        }
            .receive(on: DispatchQueue.main) // delivers values to main thread
            .eraseToAnyPublisher() //erases publishers type and return instance.
    }
}

@available(iOS 13.0, *)
struct SomeAPIWithJSON {
    static let shared = NetworkAgent.shared
    let urlString = ""
    
    static func getJSON(_ urlString: String) -> AnyPublisher<[Something], Error> {
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        return shared.run(urlRequest)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
}

struct Something: Codable {
    
}

@available(iOS 13.0, *)
let x = SomeAPIWithJSON.getJSON("x")

/*
 //@available(iOS 13.0, *)
 //struct Agent {
 //
 //    static let shared = Agent()
 //    private init() {}
 //
 //    private struct Response<T> {
 //        let value: T
 //        let response: URLResponse
 //    }
 //
 //    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
 //        URLSession.shared.dataTaskPublisher(for: request)
 //            .map({$0.data})
 //            .decode(type: T.self, decoder: JSONDecoder())
 //            .tryMap { (something) -> T in
 //                return something
 //        }
 //    }
 //}
 */

