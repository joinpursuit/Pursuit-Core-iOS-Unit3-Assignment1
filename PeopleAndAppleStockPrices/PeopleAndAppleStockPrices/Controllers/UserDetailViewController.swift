//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sunni Tang on 9/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObjects()
    }

    private func configureObjects() {
        if let user = user {
            nameLabel.text = "\(user.name.firstName.capitalized) \(user.name.lastName.capitalized)"
            emailLabel.text = user.email
            locationLabel.text = user.location.state.capitalized
            
            ImageHelper.shared.getImage(urlStr: user.picture.imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromURL):
                        self.userImage.image = imageFromURL
                    }
                }
            }
        }
    }
    
}
