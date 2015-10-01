//
//  singleImageViewController.swift
//  box of mail
//
//  Created by James Dillard on 9/30/15.
//  Copyright © 2015 James Dillard. All rights reserved.
//

import UIKit

class singleImageViewController: UIViewController {
    
// image views go here
    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var laterImageView: UIImageView!
    
// original location for singleImageView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var originalPosition: CGPoint!
    
    @IBAction func onCustomPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            print("you started panning dude")
            originalPosition = singleImageView.center
        }
        
        if sender.state == UIGestureRecognizerState.Changed{
            print("you moved")
            self.singleImageView.center.x = originalPosition.x + translation.x
        }
        
        if sender.state == UIGestureRecognizerState.Ended{
            print("all done")
            
            UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.singleImageView.center.x = self.originalPosition.x
                }, completion: { (completed) -> Void in
                    //nothing
            })
            
        }
    }

    
}
