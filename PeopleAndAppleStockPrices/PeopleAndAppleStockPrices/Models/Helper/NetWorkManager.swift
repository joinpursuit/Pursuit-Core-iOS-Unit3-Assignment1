//
//  NetWorkManager.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
class NetworkManager {
    private init() {} //we'll update this to cache
    ///singleton
    static let shared = NetworkManager()
    //Performs GET requests for any URL
    //Parameters:URL as a string
    //completion:Result with Data in success, AppError in failure
    func fetchData(urlString:String,completionHandler:@escaping(Result<Data,errorHandler>) -> ()) {
        guard let url = URL(string:urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.networkError))
                return
                
            }
            guard let retrieveData = data else {
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
                completionHandler(.failure(.unathorized))
            case 200...299:
                completionHandler(.success(retrieveData))
            default:
                completionHandler(.failure(.other(rawError: "Wrong Status Code")))
            }
        }
    }
}
