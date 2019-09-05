//
//  DetailPeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Liana Norman on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPeopleViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    // MARK: Properties
    
    var person: Person!

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()

    }
    
    // MARK: Private Methods
    
    func setUpViews() {
        peopleImageView.image = UIImage(named: "profileImage")
        nameLabel.text = person.name.description
        emailLabel.text = person.email
        dateOfBirthLabel.text = person.dob
    }

    

}
