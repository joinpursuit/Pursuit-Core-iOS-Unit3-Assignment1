//
//  StocksDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksDetailVC: UIViewController {
    
    var previousStock: Stock!
    var selectedStock: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stockImageView: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    func loadBG(){
        if previousStock.open < selectedStock.open{
            view.backgroundColor = UIColor.green
            stockImageView.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = UIColor.red
            stockImageView.image = UIImage(named: "thumbsDown")
        }
    }
    
    override func viewDidLoad() {
        dateLabel.text = selectedStock.date
        openLabel.text = "Open: $\(selectedStock.open)"
        closeLabel.text = "Close: $\(selectedStock.close)"
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
