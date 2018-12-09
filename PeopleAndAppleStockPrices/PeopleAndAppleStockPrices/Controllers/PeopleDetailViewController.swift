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
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: self.person.picture.large)
                DispatchQueue.main.async {
                    self.personImage.image = UIImage(data: imageData)
                }
            } catch {
                print("image URL Error!")
            }
        }
        
        personName.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
        personEmail.text = person.email
        personCell.text = person.cell
    }


}
