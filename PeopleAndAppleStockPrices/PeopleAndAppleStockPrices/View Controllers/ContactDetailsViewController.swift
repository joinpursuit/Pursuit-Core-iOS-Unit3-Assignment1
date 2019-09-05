//
//  ContactDetailsViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    var person: Person!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContactViews()
    }
    
    private func setUpContactViews() {
        nameLabel.text = "\(person.name.first?.capitalized ?? "") \(person.name.last?.capitalized ?? "")"
        locationLabel.text = "\(person.location.street?.capitalized ?? "N/A"), \(person.location.city?.capitalized ?? "N/A"), \(person.location.state?.capitalized ?? "N/A")"
        emailLabel.text = person.email
    }

}
