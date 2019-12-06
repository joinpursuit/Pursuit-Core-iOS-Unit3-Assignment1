//
//  DetailUserInfoViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liubov Kaper  on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailUserInfoViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var userInfoInfo: UserDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    func updateUI() {
        guard let user = userInfoInfo else {
            fatalError("cityweather is nil, verify prepare for seque")
        }
        
        navigationItem.title = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        nameLabel.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        
        emailLabel.text = user.email
        cityLabel.text = user.location.city.capitalized
    }

   

}
