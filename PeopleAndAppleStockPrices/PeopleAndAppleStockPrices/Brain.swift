//
//  Brain.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

struct Brain {
    
    static var months = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"December"]
    
    
    static func urlStringToImage(_ urlLink: String) -> UIImage? {

        let defaultImg = UIImage.init(named: "profileImage")
        guard let myImageURL = URL.init(string: urlLink) else { return defaultImg }

        do {
            let imageData = try Data(contentsOf: myImageURL)
            return UIImage(data: imageData)
        } catch {
            print("image URL Error!")
            return defaultImg
        }
    }
    
    
    static func averageOfNums(_ numbers: [Double]) -> String {
        let sum = numbers.reduce(0) {$0 + $1}
        let average = sum / Double(numbers.count)
        return String(format: "%.2f", average)
    }
    
}

