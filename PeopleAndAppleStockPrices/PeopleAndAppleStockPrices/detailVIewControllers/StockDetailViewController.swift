//
//  stockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    var stock: StockWrapper?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUp()
        setUpView()
    }
    
    func loadUp() {
        guard let stock = stock else {return }
        if stock.changePercent > 0{
             stockImage.image = UIImage(named: "thumbsUp")
            view.backgroundColor = UIColor.green
        }else {
             stockImage.image = UIImage(named: "thumbsDown")
             view.backgroundColor = UIColor.red
        }}
    private func setUpView(){
        guard let stock = stock else {
            navigationItem.title = "Error"
            return }
        navigationItem.title = "Stocks"
        dateLabel.text = stock.label
        dateLabel.font = .boldSystemFont(ofSize: 18)
        openLabel.text = "Open: $\(stock.open.description)"
        closeLabel.text = "Close: $\(stock.close.description)"
        }
    }
    
