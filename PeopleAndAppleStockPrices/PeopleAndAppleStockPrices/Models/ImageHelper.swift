//
//  ImageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    private init() {}
    
    static let shared = ImageHelper()
    
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            completionHandler(.success(image))
            
            
            }.resume()
        
        
        
    }
    
    
    
    
    
}
