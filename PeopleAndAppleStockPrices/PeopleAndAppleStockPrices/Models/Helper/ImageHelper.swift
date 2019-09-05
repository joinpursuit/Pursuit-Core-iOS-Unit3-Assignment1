//
//  ImageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
class ImageHelper {
    static let shared = ImageHelper()
    public init() {}
    func fetchImage(urlImage:String, complitionHandler: @escaping (Result<UIImage, errorHandler>) -> ()){
        NetworkManager.shared.fetchData(urlString: urlImage) { (result) in
            switch result{
            case .failure:
                fatalError()
            case .success(let data):
                guard let imaage = UIImage(data: data) else{
                    complitionHandler(.failure(.badImage))
                    return
                }
                complitionHandler(.success(imaage))
            }
        }
    }
}


