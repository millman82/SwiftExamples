//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Tim Miller on 5/13/19.
//  Copyright © 2019 Tim Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: fileImageView)
        
        fileViewOrigin = fileImageView.frame.origin
        
        view.bringSubviewToFront(fileImageView)
    }

    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        
        switch sender.state {
            
        case .began, .changed:
            
            moveViewWithPan(fileView, sender)
        case .ended:
            
            if fileView.frame.intersects(trashImageView.frame) {
                
                deleteView(view: fileView)
            } else {
                
                returnViewToOrigin(view: fileView)
            }
        default:
            break
        }
    }
    
    fileprivate func moveViewWithPan(_ view: UIView, _ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    fileprivate func returnViewToOrigin(view :UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    fileprivate func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }

}

