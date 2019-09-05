//
//  UserAPI.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class NetWorkManager {
        private init() {}
        static let shared = NetWorkManager()
        func fetchData(urlString: String,  completionHandler: @escaping (Result<Data,AppError>) -> ()) {
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.badUrl))
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completionHandler(.failure(.networkError))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.noDataError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badHTTPResponse))
                    return
                }
                
                switch response.statusCode {
                case 404:
                    completionHandler(.failure(.notFound))
                case 401,403:
                    completionHandler(.failure(.unauthorized))
                case 200...299:
                    completionHandler(.success(data))
                default:
                    completionHandler(.failure(.other(errorDescription: "Wrong Status Code")))
                }
            }.resume()
        }
}
enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case badHTTPResponse
    case badUrl
    case notFound //404 status code
    case unauthorized //403 and 401 status code
    case badImageData
    case other(errorDescription: String)
}
