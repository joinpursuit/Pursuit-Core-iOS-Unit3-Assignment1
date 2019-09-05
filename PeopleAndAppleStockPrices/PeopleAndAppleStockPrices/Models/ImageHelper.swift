//
//  ImageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init() {}
    
    static let shared = ImageHelper()
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage,Error>) -> ()) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(ErrorHandler.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(ErrorHandler.noData))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(ErrorHandler.noData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(ErrorHandler.noImage))
                return
            }
            
            completionHandler(.success(image))
            
            } .resume()
        
    }
    
}
