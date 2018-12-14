//
//  UserAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/13/18.
//  Copyright © 2018 Pursuit. All rights reserved.
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
