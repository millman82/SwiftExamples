//
//  Alert.swift
//  DoTryCatch
//
//  Created by Tim Miller on 7/15/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

class Alert {
    
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
