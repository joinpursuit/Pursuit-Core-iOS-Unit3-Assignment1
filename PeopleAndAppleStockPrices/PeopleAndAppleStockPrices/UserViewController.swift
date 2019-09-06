//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tia Lendor on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var userTableView: UITableView!
    
    var userData = [UserInfo]() {
        didSet {
            userTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        loadData()

        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else{
            fatalError("Unexpected Error: couldnt find json file")
        }
        let url = URL(fileURLWithPath: pathToJSONFile)
        do{
            let data = try Data(contentsOf: url)
            self.userData = try UserWrapper.getUserData(from: data)
        }catch{
            print(error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userInfo = userData[indexPath.row]
        let userCell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        userCell.textLabel?.text = userInfo.name.fullName
        userCell.detailTextLabel?.text = userInfo.location.city
        return userCell
    }

}
