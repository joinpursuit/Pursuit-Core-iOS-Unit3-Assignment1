//
//  UIImageView+extensions.swift
//  PeopleAndAppleStockPrices
//
//  Created by Bienbenido Angeles on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

enum NetworkError:Error {
    case badURL(String)
    case networkClient(Error)
    case noResponse
    case statusCode(Int)
    case noData
    case invalidMimeType(String)
}

extension UIImage{
    convenience init(for urlString: String, completion: @escaping (Result<UIImage?, NetworkError>) -> ()){
        
        self.init()
        //Local
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        //Gateway out to internet
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Client error
            if let error = error{
                completion(.failure(.networkClient(error)))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299:
                break
            default:
                completion(.failure(.statusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else{
                completion(.failure(.noData))
                return
            }
            
            if let mimeType = response?.mimeType{
                let imageTypes = ["jpg", "png"]
                if !imageTypes.contains(mimeType){
                    completion(.failure(.invalidMimeType("Incompatiable mime type: \(mimeType) found. Must be valid mime type of \(imageTypes.joined(separator: " "))")))
                }
            }
            
            let image = UIImage(data: data)
            completion(.success(image))
            
        }
        dataTask.resume()
    }
}
