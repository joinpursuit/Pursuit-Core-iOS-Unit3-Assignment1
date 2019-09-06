//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kevin Natera on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    var person: User!
    
    @IBOutlet weak var profilePictureImageOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    private func LoadData() {
        profilePictureImageOutlet.image = UIImage(named: "profileImage")
        nameLabel.text = person.name.fullname
        addressLabel.text = person.location.fullAddress
        phoneLabel.text = "\(person.cell)"
        emailLabel.text = "\(person.email)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       LoadData()
    }
    
}
