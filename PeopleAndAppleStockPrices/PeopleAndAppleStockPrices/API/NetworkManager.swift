//
//  UserAPI.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//


import UIKit
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}
final class NetworkManager {
  // MARK: - Static Properties
  static let manager = NetworkManager()
  // MARK: - Internal Properties
  func performDataTask(withUrl url: URL, andMethod httpMethod: HTTPMethod, completionHandler: @escaping ((Result<Data, AppError>) -> Void)) {
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue
    
    urlSession.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data else {
          completionHandler(.failure(.noDataReceived))
          return
        }
        guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
          completionHandler(.failure(.badStatusCode))
          return
        }
        
        if let error = error {
          let error = error as NSError
          if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
            completionHandler(.failure(.noInternetConnection))
            return
          } else {
            completionHandler(.failure(.other(rawError: error)))
            return
          }
        }
        completionHandler(.success(data))
      }
    }.resume()
  }
  
  // MARK: - Private Properties and Initializers
  private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
  
  private init() {}
}

public enum AppError: Error {
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}






