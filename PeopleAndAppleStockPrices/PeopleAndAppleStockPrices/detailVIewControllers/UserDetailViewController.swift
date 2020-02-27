//
//  userDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userInfo: User!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageUp()
        loadUp()
    }
    func setImageUp(){
        ImageHelper.shared.fetchImage(urlString: userInfo.picture.large) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                self.image.image = image
                }
            }
        }
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    func loadUp() {
    phone.text = userInfo.phone
    email.text = userInfo.email
    userName.text = userInfo.name.FullName()
    }
}
