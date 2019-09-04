//
//  ContactsDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    
    var contact: Contact!
    
    @IBOutlet weak var contactsImageViewOutlet: UIImageView!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    

    private func setupView() {
        contactsImageViewOutlet.image = UIImage(named: "profileImage")
        nameLabelOutlet.text = contact.fullName
        phoneLabelOutlet.text = "Phone: \(contact.phone)"
        emailLabelOutlet.text = "Email: \(contact.email)"
        
    }

}
