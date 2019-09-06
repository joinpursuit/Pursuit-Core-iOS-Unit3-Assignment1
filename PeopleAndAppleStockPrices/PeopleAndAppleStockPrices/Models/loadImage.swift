//
//  loadImage.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

func loadImages(url: URL) -> UIImage {
    var image = UIImage()
        if let data1 = try? Data(contentsOf: url) {
              image = UIImage(data: data1)!
    }
    return image
}


//func loadImage(url: URL) {
//    DispatchQueue.global().async { [weak self] in
//        if let data = try? Data(contentsOf: url) {
//            if let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self?.profilePic.image = image
//                }
//            }
//        }
//    }
//}
