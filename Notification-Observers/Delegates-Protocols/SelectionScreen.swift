//
//  SelectionScreen.swift
//  Delegates-Protocols
//
//  Created by Tim Miller on 5/14/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

class SelectionScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rebelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
