//
//  ContactsDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailController: UIViewController {
    
    var contacts:ContactInfo!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBOutlet weak var contactLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = contacts.name.fullName
        contactEmail.text = contacts.email
        contactLocation.text = contacts.location.state
        
        
        //contactImage.image = contacts.picture.large
      //  contactImage.image = contacts.picture.thumbnail
//        guard let image = URL.init(string: contacts.picture.thumbnail) else { return }
//                do {
//                     let data = try Data.init(contentsOf: image)
//                        contacts.picture.large = UIImage.init(data: data)
//
//                } catch {
//                    print(error)
//                }
        
    }
    
    func updateContact() {
        

    }

}
