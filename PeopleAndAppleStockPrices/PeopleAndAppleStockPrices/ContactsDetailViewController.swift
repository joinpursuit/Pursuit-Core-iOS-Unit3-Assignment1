//
//  ContactsDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jack Wong on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var chosenContact: ContactInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = chosenContact.name.fullname.capitalized
        
        if let url = URL.init(string: chosenContact.picture.large){
            do{
                let contactData = try Data.init(contentsOf: url)
                if let photo = UIImage.init(data: contactData){
                    imageView.image = photo
                }
            }catch{
                imageView.image = UIImage.init(named: "profileImage")
                //Personal profile image doesn't exist. Resort to using the default profile
            }
        }
        
        nameLabel.text = "\(chosenContact.name.first.capitalized) \(chosenContact.name.last.capitalized)"
        emailLabel.text = chosenContact.email
        locationLabel.text = chosenContact.location.state.capitalized
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
