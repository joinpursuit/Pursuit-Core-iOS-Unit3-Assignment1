//
//  DetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Ramu on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet weak var peoplePicture: UIImageView!
    @IBOutlet weak var peopleName: UILabel!
    @IBOutlet weak var peopleEmail: UILabel!
    @IBOutlet weak var peopleState: UILabel!
    
    var people: resultWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonalData()
}
    private func PersonalData() {
        peopleName.text = people.name.fullName
        peopleEmail.text = people.email
        peopleState.text = people.location.state.capitalized
        do {
            let imageData = try Data(contentsOf: people.picture.large)
            peoplePicture.image = UIImage(data: imageData)
        } catch {
    }
    
}
}
