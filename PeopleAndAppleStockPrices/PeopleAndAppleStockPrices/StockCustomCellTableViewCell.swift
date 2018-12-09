//
//  StockCustomCellTableViewCell.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockCustomCellTableViewCell: UITableViewCell {
  @IBOutlet weak var date: UILabel!
  
  
  @IBOutlet weak var openingPrice: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
