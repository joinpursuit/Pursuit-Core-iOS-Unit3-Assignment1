//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Donkemezuo Raymond Tariladou on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    var presentPerson:Person!
    
    @IBOutlet weak var personPhoto: UIImageView!
    
    @IBOutlet weak var personName: UILabel!
    
    @IBOutlet weak var personEmail: UILabel!
    
    @IBOutlet weak var personCity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePersonInfo()
        do {
            let imageData = try Data(contentsOf: presentPerson.picture.large)
            personPhoto.image = UIImage(data: imageData)
        } catch {
            print(error)
        }

        // Do any additional setup after loading the view.
    }
    

    private func updatePersonInfo (){
      personPhoto.image = UIImage.init(named: "profileImage")
        personName.text = presentPerson.name.fullName
        personEmail.text = presentPerson.email
        personCity.text = presentPerson.location.city.capitalized

    
    }

}
