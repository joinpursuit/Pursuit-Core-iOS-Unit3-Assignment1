//
//  StocksCell.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
