//
//  Company.swift
//  ARC_Retain_Cycles
//
//  Created by Tim Miller on 5/12/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import Foundation

class Company {
    
    let name: String
    var employees: [Employee]
    
    init(name: String) {
        self.name = name
        self.employees = []
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
