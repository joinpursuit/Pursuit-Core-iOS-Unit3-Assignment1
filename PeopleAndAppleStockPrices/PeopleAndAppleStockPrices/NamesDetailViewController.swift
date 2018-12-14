//
//  NamesDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Nathalie  on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class NamesDetailViewController: UIViewController {

    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var contactLocation: UILabel!
    var aPerson: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactPhoto.image = UIImage(named: "profileImage")
        contactName.text = "\(aPerson.name.first)" + " " + "\(aPerson.name.last)"
        contactEmail.text = aPerson.email
        contactLocation.text = aPerson.location.city

       
    }
    

}
