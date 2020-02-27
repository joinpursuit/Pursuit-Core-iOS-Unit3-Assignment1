//
//  stockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class stockDetailViewController: UIViewController {
    var stock: stockWrapper!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var close: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUp()
    }
    func loadUp() {
        if stock.changePercent > 0{
             image.image = UIImage(named: "thumbsUp")
            view.backgroundColor = UIColor.green
        }else {
             image.image = UIImage(named: "thumbsDown")
             view.backgroundColor = UIColor.red
        }
    date.text = stock.label
    open.text = stock.open.description
    close.text = stock.close.description
    }
    


}
