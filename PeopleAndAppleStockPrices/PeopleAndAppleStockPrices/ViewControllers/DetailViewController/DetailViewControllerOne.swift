//
//  DetailViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerOne:UIViewController {
    var passingInfo:Results!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var locationImage: UITextView!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailVC()
    }
    func   setUpDetailVC () {
        profilePic.image = UIImage(named: "profileImage")
        Name.text = passingInfo.name.getName()
        emailAddress.text = passingInfo.email
        locationImage.text = passingInfo.location.getLocation()
    }
}
