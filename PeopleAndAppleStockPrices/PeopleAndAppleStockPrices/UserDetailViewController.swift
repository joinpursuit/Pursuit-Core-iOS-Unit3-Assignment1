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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    private func loadUserData() {
        userName.text = "\(user.name.first) \(user.name.last)"
        userLocation.text = user.location.city
        userEmail.text = user.email
        userCell.text = user.cell
        userGender.text = user.gender
    }

}
