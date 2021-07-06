//
//  DetailPeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPeopleViewController: UIViewController {
    
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var contactsOfUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let oneContact = contactsOfUser else {
            fatalError("coule not get object from prepare for segue")
        }
        nameLabel.text = oneContact.name.first.capitalized + " " + oneContact.name.last.capitalized
        emailLabel.text = oneContact.email
        cityLabel.text = oneContact.location.city.capitalized
    }
}
