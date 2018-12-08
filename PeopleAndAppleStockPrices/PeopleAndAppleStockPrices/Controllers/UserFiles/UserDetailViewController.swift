//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Stephanie Ramirez on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    public var userSelected: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUser()

    }
    private func updateUser() {
        guard let userSelected = userSelected else {fatalError("user is nil")}
        userName.text = userSelected.name.first.capitalized + " " + userSelected.name.last.capitalized
        userEmail.text = userSelected.email
        userLocation.text = userSelected.location.city
    }



}
