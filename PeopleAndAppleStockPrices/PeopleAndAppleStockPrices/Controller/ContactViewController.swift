//
//  ContactViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Biron Su on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    var people: UserInfo?
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp() {
        do {
            let imageData = try Data(contentsOf: people!.picture.large)
            contactImageView.image = UIImage(data: imageData)
        } catch {
            print(error)
        }
        guard let people = people else {fatalError("people is nil")}
        nameLabel.text = "\(people.name.first.capitalized) \(people.name.last.capitalized)"
        emailLabel.text = people.email
        locationLabel.text = "\(people.location.city.capitalized) \(people.location.state.capitalized)"
    }
}
