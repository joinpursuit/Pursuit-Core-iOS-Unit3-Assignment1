//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!


    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        nameLabel.text = user.name.full
        cellLabel.text = user.cell
        emailLabel.text = user.email
        addressLabel.text = user.location.address
        addressLabel.numberOfLines = 0
    }
    
}
