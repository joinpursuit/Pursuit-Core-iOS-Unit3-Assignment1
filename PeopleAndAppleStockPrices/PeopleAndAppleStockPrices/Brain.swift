//
//  Brain.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

//DispatchQueue.global().async {
//    do {    //"try" keyword means try this. If it fails, catch it.
//        let imageData = try Data(contentsOf: movie.artworkUrl100)
//
//        //need to dispatch back to main thread
//        //create an image from imageData
//        DispatchQueue.main.async {
//            cell.imageView?.image = UIImage(data: imageData)
//        }
//    } catch {
//        print("contents of url error: \(error)")
//    }
//}

struct Brain {
    
    static func urlToImage(_ urlLink: URL) -> UIImage! {
        
        var image = UIImage.init(named: "profileImage")
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: urlLink)
                DispatchQueue.main.async {
                    image = UIImage(data: imageData)!
                }
            } catch {
                print("image URL Error!")
            }
        }
        
        return image
    }
    
}

