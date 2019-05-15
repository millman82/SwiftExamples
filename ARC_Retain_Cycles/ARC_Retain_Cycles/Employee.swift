//
//  Employee.swift
//  ARC_Retain_Cycles
//
//  Created by Tim Miller on 5/12/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import Foundation

class Employee {
    
    let firstName: String
    let lastName: String
    weak var company: Company?
    
    init(firstName: String, lastName: String, company: Company?) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
    }
    
    deinit {
        print("\(firstName) \(lastName) is being deinitialized")
    }
}
