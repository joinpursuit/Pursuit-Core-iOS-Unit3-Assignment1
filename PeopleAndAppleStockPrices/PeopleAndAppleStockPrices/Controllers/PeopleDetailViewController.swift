//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jian Ting Li on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personEmail: UILabel!
    @IBOutlet weak var personCell: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage()
    }
    
    func loadPage() {
        personName.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        personEmail.text = person.email
        personCell.text = person.cell
        
        Brain.urlStringToImage(person.picture.large, completionHandler: { (error, image) in
            if let error = error {
                print(error)
            } else if let image = image {
                DispatchQueue.main.async {
                    self.personImage.image = image
                }
            }
        })
        
    }


}
