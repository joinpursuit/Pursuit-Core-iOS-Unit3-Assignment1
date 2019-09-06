//
//  UsersDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Michelle Cueva on 9/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UsersDetailViewController: UIViewController {
    
    var user: User!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        loadImage()

    }
    
    private func setLabels() {
        nameLabel.text = user.getFullName()
        phoneLabel.text = user.getPhoneNumber()
        emailLabel.text = user.email
        dateOfBirthLabel.text = user.getDOB()
        
    }
    
    
    private func loadImage() {
        ImageHelper.shared.getImage(urlStr: user.picture.picture) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.userImage.image = imageFromOnline
                }
            }
        }
    }

}
