//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Matthew Huie on 12/9/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {

    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    var people: ResultsWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

      
    }
    
    private func updateUI() {
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: self.people.picture.large)
                DispatchQueue.main.async {
                    self.peopleImage.image = UIImage(data: imageData)
                }
            } catch {
                print(error)
            }
        }
       
        nameLabel.text = "\(people.name.first.capitalized) \(people.name.last.capitalized)"
        emailLabel.text = people.email
        stateLabel.text = people.location.state.capitalized
    }
    

   

}
