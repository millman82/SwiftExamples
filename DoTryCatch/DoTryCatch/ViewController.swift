//
//  ViewController.swift
//  DoTryCatch
//
//  Created by Tim Miller on 6/24/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        do {
            try login()
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email", message: "Please make sure you format you email correctly", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 8 characters", vc: self)
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
    }
    
    func login() throws {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
        
            if email.isEmpty || password.isEmpty {
                throw LoginError.incompleteForm
            }
            
            if !email.isValidEmail {
                throw LoginError.invalidEmail
            }
            
            if password.count < 8 {
                throw LoginError.incorrectPasswordLength
            }
        } else {
            throw LoginError.incompleteForm
        }
        
        // Pretend this is great code that logs in my user
        // It really is amazing...
    }

}

