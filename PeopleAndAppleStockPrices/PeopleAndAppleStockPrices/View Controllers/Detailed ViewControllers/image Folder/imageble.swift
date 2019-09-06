//
//  imageble.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kary Martinez on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

protocol imageble {
    var imageName: String {get}
    func getImage() -> UIImage
}
