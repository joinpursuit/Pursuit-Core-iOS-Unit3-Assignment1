//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {
    
    var information = [PeoplesInfo]() {
        didSet {
            peoplesTableView.reloadData()
        }
    }
    
    @IBOutlet weak var peoplesTableView: UITableView!
    
    @IBOutlet weak var mysearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peoplesTableView.dataSource = self
        peoplesTableView.delegate = self
        peoplesloadData()
        mysearchBar.delegate = self
        dump(information)
        
    }
    
    func peoplesloadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let peopleURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: peopleURL) {
                do {
                    let info = try JSONDecoder().decode(People.self, from: data)
                    self.information = info.results
                    self.information.sort{$0.name.first < $1.name.first}
                } catch {
                    print("my error \(error)")
                }
            }
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destination = segue.destination as? peopleDetailController,
        let cellSelected = peoplesTableView.indexPathForSelectedRow else {return}
        let cellinfo = information[cellSelected.row]
        destination.detailPeople = cellinfo
    }
    
    
    
}

extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = peoplesTableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as? peoplesCell else {return UITableViewCell()}
        let basicInfo = information[indexPath.row]
        cell.name.text = ("\(basicInfo.name.title.capitalized).\(basicInfo.name.first.capitalized) \(basicInfo.name.last.capitalized)")
        cell.userlocation.text = ("Location: \(basicInfo.location.city.capitalized)")

            guard let imageUrl = URL.init(string: basicInfo.picture.medium) else { return UITableViewCell() }
            do {
                let data = try Data.init(contentsOf: (imageUrl))
                cell.userImage?.image = UIImage.init(data: data)
            } catch {
                print(error)
            }
    

        //cell.userImage.image = UIImage(named:basicInfo.pictures)
        return cell
        
    }
    
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ProfileView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        if searchBar.text == "" || searchBar.text == " " {
//
//            return
//        }
        
        information = information.filter{$0.name.first.lowercased().contains(searchBar.text!.lowercased())}
        searchBar.resignFirstResponder()
        searchBar.text = ""
    
    }
    
   
}


