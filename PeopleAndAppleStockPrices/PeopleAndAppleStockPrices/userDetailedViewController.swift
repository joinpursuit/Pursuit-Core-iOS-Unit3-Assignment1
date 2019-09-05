//
//  userDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Kary Martinez on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class userDetailedViewController: UIViewController {

     var currentUser: ResultsWrapper!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    
    func loadImage() {
        let urlStr = currentUser.picture.large
        guard let url = URL(string: urlStr) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do { let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            } catch {fatalError()}
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        labelOne.text = currentUser.email
        labelTwo.text = currentUser.getLocation()
//       moreinfoLabel.text = "\(currentUser.location.street)"

        // Do any additional setup after loading the view.
    }
    

}
