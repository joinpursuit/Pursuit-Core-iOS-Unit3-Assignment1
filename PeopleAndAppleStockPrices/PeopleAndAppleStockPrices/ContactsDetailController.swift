//
//  ContactsDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jeffrey Almonte on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailController: UIViewController {
var contacts = [ContactInfo]()
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBOutlet weak var contactLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    func updateContact() {
        

    }

}
