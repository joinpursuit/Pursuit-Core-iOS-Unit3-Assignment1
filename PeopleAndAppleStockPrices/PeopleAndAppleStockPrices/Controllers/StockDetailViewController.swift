//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Waring on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    var appl: AppleStockInfo?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    private func setUp(){
        guard let appl = appl else {fatalError("nil")}
        dateLabel.text = appl.date
        openLabel.text = "Open $\(String(format: "%.2f", appl.open))"
        closeLabel.text = "Close $\(String(format: "%.2f", appl.close))"
        if appl.open < appl.close {
            imageView.image = UIImage(named: "thumbs up")
            view.backgroundColor = .green
        } else if appl.open > appl.close {
            imageView.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red 
        }
        }
    

    

}
