//
//  DetailStockController.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailStockController: UIViewController {
var stock: StockInfo!
    
    
    
    @IBOutlet weak var StockImage: UIImageView!
    @IBOutlet weak var DateStockLabel: UILabel!
    @IBOutlet weak var openStockLabel: UILabel!
    @IBOutlet weak var endStockLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        setUpImage()

        
    }
    func setUpUI(){
        DateStockLabel.text = stock.date.capitalized
        openStockLabel.text = String(stock.open)
        endStockLabel.text = String(stock.close)
}

//    func setUpImage(){
//        if let url = URL.init(string: stock.picture.large) {
//            do{
//                let data = try Data.init(contentsOf: url)
//                if let image = UIImage.init(data: data){
//                    personImage.image = image
//                }
//            } catch {
//
//
//                  StockImage.image = UIImage.init(named: "<#T##String#>")
////                print("\(error)")
//
//
//
}
