//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alexander George Legaspi on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCell: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    private func loadUserData() {
        userImage.image = UIImage(named: "profileImage")
        userName.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        userLocation.text = user.location.city.capitalized
        userEmail.text = user.email
        userCell.text = user.cell
        userGender.text = user.gender.capitalized
    }
    
}
