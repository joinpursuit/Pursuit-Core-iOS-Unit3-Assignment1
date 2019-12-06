//
//  DetailStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liubov Kaper  on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailStockViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    var stockWhole: Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     updateUI()
       
    }
    func updateUI() {
        guard let stock = stockWhole else {
            fatalError("couldn't set stock object, check prepare(for segue: )")
        }
        if stock.change >= 0 {
            imageView.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            imageView.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red
        }
        dateLabel.text = stock.date
        openLabel.text = "Open: $\(stock.open)"
        closeLabel.text = "Close: $\(stock.close)"
        
    }

   
}
