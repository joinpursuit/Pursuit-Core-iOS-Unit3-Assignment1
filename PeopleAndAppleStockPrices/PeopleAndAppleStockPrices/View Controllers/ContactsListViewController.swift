//
//  ContactsListViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Jason Ruan on 9/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController, UITableViewDataSource {
    
    //MARK: -- IBOutlets
    @IBOutlet weak var contactsListTableView: UITableView!
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsListTableView.dataSource = self
        // Do any additional setup after loading the view.
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
