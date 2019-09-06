//
//  DetailPeopleController.swift
//  PeopleAndAppleStockPrices
//
//  Created by hildy abreu on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPeopleController: UIViewController {
    
    var person: PeopleInfo!

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpImage()

    }
    

    func setUpUI(){
        nameLabel.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        emailLabel.text = person.email.capitalized
        locationLabel.text = "\(person.location.city.capitalized) \(person.location.state.capitalized)"
        
    }
    
    
    func setUpImage(){
        if let url = URL.init(string: person.picture.large) {
            do{
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data){
                    personImage.image = image
                }
            } catch {
                
              //  personImage.image = UIImage.init(named: "<#T##String#>")
                print("\(error)")
                
            }
        }
    }
    
    

}
