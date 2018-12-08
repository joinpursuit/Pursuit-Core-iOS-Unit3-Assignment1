//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    var people = [People]()

  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    // Do any additional setup after loading the view, typically from a nib.
  }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json")
        {
            let myUrl = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myUrl) {
                do {
                    self.people = try JSONDecoder().decode([People].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }

}

