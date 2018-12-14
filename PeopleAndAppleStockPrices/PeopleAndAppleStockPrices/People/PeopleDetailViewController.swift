//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Genesis Mosquera on 12/11/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {

    @IBOutlet weak var peopleImage: UIImageView!
    
    @IBOutlet weak var peopleName: UILabel!
    
    @IBOutlet weak var peopleEmail: UILabel!
    
    @IBOutlet weak var peopleCity: UILabel!
    
    public var peopleData: ResultWrapper?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      updatePeopleUI()
        peopleName.text = "\(peopleData!.name.first.capitalized) \(peopleData!.name.last.capitalized)"
        peopleEmail.text = peopleData?.email
        peopleCity.text = peopleData?.location.city
       
    }
    
    
     func updatePeopleUI() {
            do {
                guard let peoplesPictures = self.peopleData
                    else { return }
                
              let peopleImage = try Data (contentsOf: peoplesPictures.picture.large)
                self.peopleImage.image = UIImage(data: peopleImage)
            } catch {
                print(error)
            }
}
}
