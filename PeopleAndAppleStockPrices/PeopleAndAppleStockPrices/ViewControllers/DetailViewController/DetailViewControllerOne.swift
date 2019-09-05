//
//  DetailViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerOne:UIViewController {
    var passingInfo:Results!
    var rgbColor = RGBValue()
    var randomColor:UIColor!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var locationImage: UITextView!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailVC()
    }
    func   setUpDetailVC () {
        DispatchQueue.main.async {
            self.profilePic.image = loadImages(url: self.passingInfo.picture.large)
        }
        
        changeImageShape()
        Name.text = passingInfo.name.getName()
        emailAddress.text = passingInfo.email
        locationImage.text = passingInfo.location.getLocation()
        
        self.navigationItem.title = "User Information"
        setUpColors()
    }
    func setUpColors(){
        self.navigationController?.navigationBar.backgroundColor = randomColor
        self.view.backgroundColor = randomColor
        locationImage.backgroundColor = randomColor
        profilePic.backgroundColor = randomColor

    }
    
    func changeImageShape() {
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
        profilePic.layer.borderWidth = 0
    }
}
