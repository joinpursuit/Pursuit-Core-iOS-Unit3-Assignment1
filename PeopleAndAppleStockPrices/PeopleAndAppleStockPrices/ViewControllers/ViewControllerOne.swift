//
//  ViewControllerOne.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

class RandomUserViewController:UIViewController {
    @IBOutlet weak var randomUserTableView: UITableView!
    var randomUser = [Results]() {
        didSet {
            randomUserTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  private func getData() {
    UserAPIClient.shared.fetchData { (results) in
        switch results {
        case .success(let user):
            self.randomUser = user.results
        case .failure(let failure):
            print("could not retrieve Data \(failure)")
        }
    }
    }
}
extension RandomUserViewController: UITableViewDelegate{}
extension RandomUserViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  randomUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = randomUserTableView.dequeueReusableCell(withIdentifier: "randomUser")
        cell?.textLabel?.text = randomUser[indexPath.row].name.getName()
        cell?.detailTextLabel?.text = randomUser[indexPath.row].location.city
        return cell!
    }
    
    
}
