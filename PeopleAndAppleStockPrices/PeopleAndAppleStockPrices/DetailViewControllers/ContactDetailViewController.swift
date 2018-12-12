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
    @IBOutlet weak var firstAndLastNames: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    
    @IBOutlet weak var homeAddress: UILabel!
    var contact : ContactDetails!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactImage.image?.accessibilityIdentifier = contact.picture.medium
        firstAndLastNames.text = contact.name.first.lowercased()
        email.text = contact.email
        dateOfBirth.text = contact.dob
       
    }
    

}
