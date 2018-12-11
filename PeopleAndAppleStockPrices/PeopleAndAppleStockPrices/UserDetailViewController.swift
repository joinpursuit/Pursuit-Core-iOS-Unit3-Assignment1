//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Aaron Cabreja on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var profileView: User!
    @IBOutlet weak var peopleImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel?.text = profileView.name.fullName//profileView.name.first.capitalized + " " + profileView.name.last.capitalized
        emailLabel?.text = profileView.email
        cityLabel?.text = profileView.location.city.capitalized
        DispatchQueue.global().async {
            do {
                guard let url = URL.init(string: self.profileView.picture.large!) else {return}
                let peopleImageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.peopleImage.image = UIImage.init(data: peopleImageData)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
}
