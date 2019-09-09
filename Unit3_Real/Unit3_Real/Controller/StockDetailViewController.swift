//
//  StockDetailViewController.swift
//  Unit3_Real
//
//  Created by EricM on 9/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    var apple: Stock!
    @IBOutlet weak var image2Outlet: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if apple.open < apple.close{
            image2Outlet.image = UIImage(named: "thumbsDown")
            self.view.backgroundColor = .red
        }else {
            image2Outlet.image = UIImage(named: "thumbsUp")
            self.view.backgroundColor = .green
        }
        dateLabel.text = apple.date
        openLabel.text = "Open: $\(apple.open)"
        closeLabel.text = "Close: $\(apple.close)"

        // Do any additional setup after loading the view.
    }
    


}
