//
//  PeopleDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Leandro Wauters on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    
    var user: People!
    
    @IBOutlet weak var userImage: UIImageView!//WATCH IT THE NAME WAS REFACTOR!!!!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    func updateUI(){
        DispatchQueue.global().async {
            do{
                let imageData = try Data(contentsOf: self.user!.picture.large)
                DispatchQueue.main.async {
                    self.userImage.image = UIImage(data: imageData)
                }
            } catch {
                print(error)
            }
        }
    }

}
