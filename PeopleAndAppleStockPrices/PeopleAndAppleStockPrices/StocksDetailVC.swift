//
//  StocksDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailVC: UIViewController {
    
    var previousDate: Stock!
    var selectedDate: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stockImageView: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    func loadBG(){
        if previousDate.open < selectedDate.open{
            view.backgroundColor = UIColor.green
            stockImageView.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = UIColor.red
            stockImageView.image = UIImage(named: "thumbsDown")
        }
    }
    
    override func viewDidLoad() {
        dateLabel.text = selectedDate.date
        openLabel.text = "Open: $\(selectedDate.open)"
        closeLabel.text = "Close: $\(selectedDate.close)"
        loadBG()
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
