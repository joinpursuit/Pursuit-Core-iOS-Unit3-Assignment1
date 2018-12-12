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
  @IBOutlet weak var email: UILabel!
  @IBOutlet weak var address: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setContactDetailedView()
  }
  
  func setContactDetailedView(){
    fullName.text = detailedContactInfo.name.fullName
    address.text = detailedContactInfo.location.fullAddress
    email.text = "email: \(detailedContactInfo.email)"
    
    //    contactImage.image = UIImage(named: "profileImage")
    
    DispatchQueue.global().async {
      
      do{
        let data = try Data(contentsOf: self.detailedContactInfo.picture.large)
        DispatchQueue.main.async {
          self.contactImage.image = UIImage(data: data)
        }
      } catch {
        print("The image error is: \(error)")
      }
    }
  }
}



