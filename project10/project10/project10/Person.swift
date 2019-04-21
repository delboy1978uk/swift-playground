//
//  Person.swift
//  project10
//
//  Created by Derek Stephen McLean on 21/04/2019.
//  Copyright © 2019 Derek Stephen McLean. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
