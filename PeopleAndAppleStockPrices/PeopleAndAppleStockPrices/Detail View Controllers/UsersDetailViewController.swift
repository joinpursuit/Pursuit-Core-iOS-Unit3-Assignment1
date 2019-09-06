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
    
    func setLabels() {
        nameLabel.text = user.getFullName()
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        dateOfBirthLabel.text = user.getDOB()
        
    }
    
    func loadImage() {
        let urlStr = user.picture.picture
        guard let url = URL(string: urlStr) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do { let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            } catch {fatalError()}
        }
    }

}
