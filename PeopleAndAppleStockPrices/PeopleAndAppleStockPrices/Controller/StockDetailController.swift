//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Biron Su on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailController: UIViewController {
    var stockInfo: AppleStockInfo?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    private func setUp() {
        guard let stockInfo = stockInfo else {fatalError("stockInfo is nil")}
        dateLabel.text = stockInfo.date
        openLabel.text = "Open: $\(String(format: "%.2f", stockInfo.open))"
        closeLabel.text = "Close: $\(String(format: "%.2f", stockInfo.close))"
    }
}

