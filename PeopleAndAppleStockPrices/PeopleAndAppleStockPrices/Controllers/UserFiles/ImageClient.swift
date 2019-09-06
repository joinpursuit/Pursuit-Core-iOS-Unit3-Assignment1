//
//  UserAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by 马文龙 on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

final class ImageClient {
    static func getImage(StringURL: String) -> UIImage? {
        guard let myImageURL = URL.init(string: StringURL) else {return nil}
        do {
            let data = try Data.init(contentsOf: myImageURL)
            guard let image = UIImage.init(data: data) else {return nil}
            return image
        } catch {
            print(error)
            return nil
        }
    }
}
