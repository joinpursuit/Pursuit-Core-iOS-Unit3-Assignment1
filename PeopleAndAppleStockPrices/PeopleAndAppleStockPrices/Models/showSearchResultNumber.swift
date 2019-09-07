//
//  showSearchResultNumber.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
struct showResults {
static func showResults(int:Int) -> String {
    switch int {
    case 50:
        return  "Contacts"
    case 1:
        return "1 search result"
    case 0:
        return "Your search did not match any user profiles"
    default:
        return "\(int) search results"
    }
}
}
