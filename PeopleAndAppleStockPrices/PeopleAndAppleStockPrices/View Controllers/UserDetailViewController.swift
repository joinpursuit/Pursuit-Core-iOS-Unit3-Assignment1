//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Radharani Ribas-Valongo on 9/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    //MARK: -- Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    //MARK: -- Properties
    var users: User!
    
    //MARK: -- Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        emailLabel.text = users.email
        phoneLabel.text = users.cell
        cityLabel.text = users.location.city.capitalized
        nameLabel.text = "\(users.name.firstName.capitalized) \(users.name.lastName.capitalized)"
        
        let urlStr = users.picture.medium
        
        guard let url = URL(string: urlStr) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            } catch {
                print("could not load image")
            }
        }
    }
}
