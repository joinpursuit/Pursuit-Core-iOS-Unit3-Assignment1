//
//  ContactDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by katty y marte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    var image: UIImage!
    @IBOutlet weak var homeAddress: UILabel!
    var contact : ContactDetails!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.text = contact.fullName.capitalized(with: nil)
        email.text = contact.email
        dateOfBirth.text = contact.dob
        homeAddress.text = contact.location.street.capitalized
        if let url = URL(string: contact.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.contactImage.image = UIImage(data: data)
                    }
                }
                
            }
        }

     
}
}

