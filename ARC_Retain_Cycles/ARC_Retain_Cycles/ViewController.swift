//
//  ViewController.swift
//  ARC_Retain_Cycles
//
//  Created by Tim Miller on 5/12/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var company: Company?
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObjects()
        assignObjects()
    }
    
    func createObjects() {
        company = Company(name: "My Company, LLC")
        employee = Employee(firstName: "Tim", lastName: "Miller", company: nil)
    }
    
    func assignObjects() {
        company?.employees.insert(employee!, at: 0)
        employee?.company = company
        
        company = nil
        employee = nil
    }

}

