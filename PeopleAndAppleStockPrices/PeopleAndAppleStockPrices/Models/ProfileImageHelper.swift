//
//  ProfileImageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

struct ProfileImageHelper {
    private init() {}
    static let manager = ProfileImageHelper()
    
    func getProfilePic(imageURL: URL, completionHandler: @escaping (Result<UIImage, ErrorHandler>) -> () ) {
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard error == nil else {
                completionHandler(.failure(ErrorHandler.noData))
                return
            }
            guard let data = data else {
                completionHandler(.failure(ErrorHandler.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(ErrorHandler.noData))
                return
            }
            completionHandler(.success(image))
        }.resume()
    }
}
