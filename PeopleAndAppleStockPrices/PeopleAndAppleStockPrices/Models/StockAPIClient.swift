//
//  UserAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct StockAPIClient {
    static var shared = StockAPIClient()
    let stockUrl =
        
"https://sandbox.iexapis.com/stable/stock/AAPL/chart/1m?token=Tpk_99a13d1c51654f2ab13764626efa902a"

    func fetchData(completionHandler:@escaping (Result<[Stocks],Error>) -> ()) {
        guard let url = URL(string: stockUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                completionHandler(.failure(err))
            }
            guard let retrieveData = data else {fatalError(String(describing: error))}
            do {
                let stocks = try JSONDecoder().decode([Stocks].self, from: retrieveData)
                
                completionHandler(.success(stocks))
            } catch let JSONError {
                completionHandler(.failure(JSONError))
            }
            }.resume()
        
    }
}
