//
//  UserDetailTableViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailTableViewController: UIViewController {
    
    var userDetails: UserInfo!

    @IBOutlet weak var userDetailedImage: UIImageView!
    
    @IBOutlet weak var userDetailName: UILabel!
    
    @IBOutlet weak var userDetailEmail: UILabel!
    
    @IBOutlet weak var userDetailCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userDetailedImage.image = UIImage(named: "profileImage")
        userDetailName.text = userDetails.name.fullName
        userDetailEmail.text = userDetails.email
        userDetailCity.text = userDetails.location.city
    }

   

}
