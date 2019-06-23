//
//  ViewController.swift
//  Delegates-Protocols
//
//  Created by Tim Miller on 5/14/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

let lightNotificationKey  = "co.sideSelector.lightSide"
let darkNotificationKey = "co.sideSelector.darkSide"

class HomeScreen: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    let light = Notification.Name(rawValue: lightNotificationKey)
    let dark = Notification.Name(rawValue: darkNotificationKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = chooseButton.frame.size.height / 2
        createObservers()
    }
    
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        present(selectionVC, animated: true, completion: nil)
    }
    
    func createObservers() {
        
        // Light
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateCharacterImage(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateNameLabel(notifcation:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateBackground(notification:)), name: light, object: nil)
        
        // Dark
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateCharacterImage(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateNameLabel(notifcation:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeScreen.updateBackground(notification:)), name: dark, object: nil)
    }
    
    @objc func updateCharacterImage(notification: Notification) {
        
        let isLight = notification.name == light
        let image = isLight ? UIImage(named: "luke") : UIImage(named: "vader")
        mainImageView.image = image
    }
    
    @objc func updateNameLabel(notifcation: Notification) {
        
        let isLight = notifcation.name == light
        let name = isLight ? "Luke Skywalker" : "Darth Vader"
        nameLabel.text = name
    }
    
    @objc func updateBackground(notification: Notification) {
        
        let isLight = notification.name == light
        let color = isLight ? UIColor.cyan : UIColor.red
        view.backgroundColor = color
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
