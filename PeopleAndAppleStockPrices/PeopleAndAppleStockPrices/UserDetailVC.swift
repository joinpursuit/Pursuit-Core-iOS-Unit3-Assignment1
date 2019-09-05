//
//  UserDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {

    var user: User!
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        nameLabel.text = user.name.fullName()
        emailLabel.text = user.email
        addressLabel.text = user.location.fullAddress()
        user.picture.loadImage(imageView: userImageView)
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        super.viewDidLoad()

        
    }
    

}
