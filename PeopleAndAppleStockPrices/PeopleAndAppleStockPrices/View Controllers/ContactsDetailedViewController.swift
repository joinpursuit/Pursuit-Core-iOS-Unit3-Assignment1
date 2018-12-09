//
//  ContactsDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Elizabeth Peraza  on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailedViewController: UIViewController {
  
  var detailedContactInfo: ResultsToSet!

  @IBOutlet weak var contactImage: UIImageView!
  @IBOutlet weak var fullName: UILabel!
  @IBOutlet weak var cellPhone: UILabel!
  @IBOutlet weak var email: UILabel!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setContactDetailedView()
    }
  
  func setContactDetailedView(){
   fullName.text = detailedContactInfo.name.getFullName()
    
  }


}
