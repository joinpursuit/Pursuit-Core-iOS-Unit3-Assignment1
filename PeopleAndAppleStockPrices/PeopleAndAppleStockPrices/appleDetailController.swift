//
//  appleDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 12/13/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class appleDetailController: UIViewController {

    var appleDetailView: appleStocks!
    
    @IBOutlet weak var appleimage: UIImageView!
    @IBOutlet weak var appleclose: UILabel!
    @IBOutlet weak var appleopen: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if appleDetailView.close > appleDetailView.open {
            appleimage.image = UIImage.init(named: "thumbsUp")
            view.backgroundColor = .green
            appleclose.text = "Close: \(appleDetailView.close)"
            appleopen.text = "Open: \(appleDetailView.open)"
        } else {
            appleimage.image = UIImage.init(named: "thumbsDown")
            view.backgroundColor = .red
            appleclose.text = "Close: \(appleDetailView.close)"
            appleopen.text = "Open: \(appleDetailView.open)"
        }
        
    }
    


}
