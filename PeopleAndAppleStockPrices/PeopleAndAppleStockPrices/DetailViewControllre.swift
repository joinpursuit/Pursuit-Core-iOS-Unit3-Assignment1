//
//  DetailViewControllre.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jose Alarcon Chacon on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class DetailViewControllre: UIViewController {
    
   var resultToSet: ResultsToSet!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     labelName.text = resultToSet.name.first.capitalized
     labelCity.text = resultToSet.location.city.capitalized
     labelEmail.text = resultToSet.email
    }
}
