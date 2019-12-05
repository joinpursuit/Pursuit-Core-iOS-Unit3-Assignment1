//
//  DetailedUserInfoViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Cameron Rivera on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedUserInfoViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    // MARK: Properties
    var currentUser: User?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        guard let curUser = currentUser else {
            print("Could not obtain an instance of user")
            return
        }
        
        fullNameLabel.text = "Name: \(curUser.name.first.capitalized)" + " " + "\(curUser.name.last.capitalized)"
        emailLabel.text = "Email: \(curUser.email)"
        dobLabel.text = "Date of Birth: \(UserInfo.displayDate(date: curUser.dob.components(separatedBy: " ").first!))"
        
    }

}
