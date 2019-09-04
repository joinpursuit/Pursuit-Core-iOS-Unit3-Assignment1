//
//  StocksDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailVC: UIViewController {
    
    var selectedDate: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stockImageView: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    override func viewDidLoad() {
        dateLabel.text = selectedDate.date
        openLabel.text = "Open: $\(selectedDate.open)"
        closeLabel.text = "Close: $\(selectedDate.close)"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
