//
//  ImageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init () {}
    
    static let shared = ImageHelper()
    func getImage(urlString: String, completionHandler: @escaping(Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ErrorHandling.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) {(data,_, error) in
            guard error == nil else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            guard let data = data else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            completionHandler(.success(image))
        } .resume()
    }
}

           



