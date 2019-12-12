//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: Stock!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    private func configureView() {
        if stock.open > stock.close {
            imageView.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .systemRed
        } else {
            imageView.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .systemGreen
        }
        dateLabel.text = stock.date
        openLabel.text = String(format: "$ %.2f", stock.open)
        closeLabel.text = String(format: "$ %.2f", stock.close)
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
