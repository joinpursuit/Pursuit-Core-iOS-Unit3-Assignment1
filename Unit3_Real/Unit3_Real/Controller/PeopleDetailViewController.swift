//
//  PeopleDetailViewController.swift
//  Unit3_Real
//
//  Created by EricM on 9/4/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    var peopleInfo: Person!
    
    @IBOutlet weak var image1Outlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(peopleInfo.name.first) \(peopleInfo.name.last)"
        emailLabel.text = peopleInfo.email
        cityLabel.text = peopleInfo.location.city
        loadImage(site: peopleInfo.picture.large)
    }
    
    func loadImage(site: String){
        let urlStr = site
        guard let url = URL(string: urlStr) else{return}
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image1Outlet.image = image
                }
            } catch {
                fatalError()
            }
        }
    }
    


}
