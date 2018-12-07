//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    
  }

    func loadData(){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl){
                do {
                    let searchData = try JSONDecoder().decode(People.searchData.self, from: data)
                    dump(searchData)
                } catch {
                    print(error)
                }
            }
        }
    }
}

