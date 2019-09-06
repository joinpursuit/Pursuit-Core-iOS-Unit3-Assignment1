//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Krystal Campbell on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    
    var allPeople: resultsInfo!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactCity: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
//    ImageHelper.shared.getImage(urlString:person.thumbnail) { (result) in
//    DispatchQueue.main.async {
//    switch result {
//    case .failure(let error):
//    print(error)
//    case .success(let imageFromOnline):
//    contactImage.
//    }
//    }
//    
//    }
//    
    func setUpLabel () {
        contactName.text = "\(allPeople.name.first.capitalized) \(allPeople.name.last.capitalized)"
        contactCity.text = allPeople.location.city
        contactEmail.text = allPeople.email
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()

    }
}
