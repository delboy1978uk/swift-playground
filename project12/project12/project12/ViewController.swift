//
//  ViewController.swift
//  project12
//
//  Created by Derek Stephen McLean on 01/05/2019.
//  Copyright © 2019 Derek Stephen McLean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        let arrayValue = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        let dictValue = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
        
    }


}

