//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Yuliia Engman on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var openStockLabel: UILabel!
    @IBOutlet weak var closedStockLabel: UILabel!
    
    var someStock: StockData?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let oneStock = someStock else {
            fatalError("coule not get object from prepare for segue")
        }
        
        dateLabel.text = oneStock.label
        openStockLabel.text = String(oneStock.open)
        closedStockLabel.text = String(oneStock.close)
        
        if oneStock.close > oneStock.open {
            image.image = UIImage(named: "thumbsUp")
        } else {
            image.image = UIImage(named: "thumbsDown")
        }
    }
    
    
//    var someJoke: Joke?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateUI()
//    }
//
//    func updateUI() {
//        guard let oneJoke = someJoke else {
//            fatalError("could not get object from prepare for segue")
//        }
//        textView.text = oneJoke.punchline
//
//    }

}

//
//var switchValue: Bool = true { // e.g. switchValue = true
//    // property observer - observes changes on property: willSet or didSet
//    didSet {
//        // update switch label
//        switchLabel.text = "The switch is \(switchControl.isOn ? "on" : "off")"
//    }
//}
//
//var cohort: Double = 6.9 {
//    didSet {
//        stepperLabel.text = "Looking at \(stepperControl.value) Cohort."
//    }
//}
//
//var currentSegmentIndex: Int = 0{
//    didSet {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            imageView.image = #imageLiteral(resourceName: "cat")
//        case 1:
//            imageView.image = #imageLiteral(resourceName: "dog")
//        default:
//            imageView.image = #imageLiteral(resourceName: "pitons")
//        }
//    }
//}
//
//var currentYear: Float = 2012 {
//    didSet {
//        sliderLabel.text = String(format: "%0.f", sliderControl.value)
//    }
//}
//
//// MARK: - View Controller Life Cycle methods
//override func viewDidLoad() {
//    super.viewDidLoad()
//    configureStepper()
//    configureSlide()
//
//    // Do any additional setup after loading the view.
//}
//
//func configureStepper() {
//    stepperControl.minimumValue = 1.0
//    stepperControl.maximumValue = 7.0
//    stepperControl.stepValue = 1.0
//    
//    // default start value
//    stepperControl.value = 6.0
//}
//
//func configureSlide() {
//    sliderControl.minimumValue = 1978
//    sliderControl.maximumValue = 2019
//    sliderControl.value = 2012
//}
//
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(true)
//    print("cvc - viewWillAppear")
//}
//
//// MARK: - actions and methods
//
//@IBAction func switchToggled(_ sender: UISwitch) {
//    switchValue = sender.isOn // of type Bool, true or false
//}
//
//@IBAction func stepperChanged(_ sender: UIStepper) {
//    cohort = sender.value // of type Double
//}
//
//@IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
//    currentSegmentIndex = sender.selectedSegmentIndex //0, 1
//}
//
//
//@IBAction func sliderChanged(_ sender: UISlider) {
//    currentYear = sender.value
//}
