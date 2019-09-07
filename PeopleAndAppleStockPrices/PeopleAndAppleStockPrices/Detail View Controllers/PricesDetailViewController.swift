//
//  PricesDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PricesDetailViewController: UIViewController {
    
    var price: Stock!

    @IBOutlet weak var someImageOutlet: UIImageView!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var openingPriceLabelOutlet: UILabel!
    @IBOutlet weak var closingPriceLabelOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    

    private func setupView() {
        selectImage()
        dateLabelOutlet.text = price.date
        openingPriceLabelOutlet.text = "\(price.open)"
        closingPriceLabelOutlet.text = "\(price.close)"
    }

    private func selectImage() {
        if price.open > price.close {
            someImageOutlet.image = UIImage(named: "thumbsDown")
        } else {
            someImageOutlet.image = UIImage(named: "thumbsUp")
        }
    }
    
}
