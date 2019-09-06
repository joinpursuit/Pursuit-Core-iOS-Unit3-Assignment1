//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by 马文龙 on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    public var userSelected: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUser()
        
    }
    private func updateUser() {
        guard let userSelected = userSelected else {fatalError("user is nil")}
        userName.text = userSelected.name.first.capitalized + " " + userSelected.name.last.capitalized
        userEmail.text = userSelected.email
        userLocation.text = userSelected.location.city
        if let imageUrl = userSelected.picture.large {
            if let image = ImageClient.getImage(StringURL: imageUrl) {
                userImage.image = image
            }
        }
    }
    
    
    
}
