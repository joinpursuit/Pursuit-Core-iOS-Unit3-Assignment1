//
//  peopleDetailController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Pursuit on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class peopleDetailController: UIViewController {

    var detailPeople: PeoplesInfo!
    
    @IBOutlet weak var peoplesimage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var peoplesEmail: UILabel!
    @IBOutlet weak var peoplesLocation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nameLabel.text = "\(detailPeople.name.title.capitalized) \(detailPeople.name.first.capitalized) \(detailPeople.name.last.capitalized)"
       peoplesEmail.text = detailPeople.email
       peoplesLocation.text = detailPeople.location.city
        guard let imageURL = URL.init(string: detailPeople.picture.medium) else { return  }
        do {
            let data = try Data.init(contentsOf: (imageURL))
            peoplesimage.image = UIImage.init(data: data)
        } catch {
            print(error)
        }
    }
}
