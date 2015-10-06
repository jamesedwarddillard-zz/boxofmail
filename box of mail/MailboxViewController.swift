//
//  MailboxViewController.swift
//  box of mail
//
//  Created by James Dillard on 9/30/15.
//  Copyright © 2015 James Dillard. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {
    
    // image variables here
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var helpImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var navImageView: UIImageView!
    @IBOutlet weak var singleImageView: UIImageView!
    
    // image icons here
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var deleteIconImageView: UIImageView!
    @IBOutlet weak var listIconImageView: UIImageView!
    
    //bacgkround goes here
    @IBOutlet weak var backgroundView: UIView!
    
    
    // view for single message and icons
    @IBOutlet weak var topMessageView: UIView!
    
    //location variables
    var originalSingleImage: CGPoint!
    var laterIconValue: CGFloat!
    var archiveIconValue: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = feedImageView.image!.size
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCustomPan(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var singleImageOriginX = self.singleImageView.frame.origin.x
        
        // notice when panning begins
        if sender.state == UIGestureRecognizerState.Began {
            // set the scene
            originalSingleImage = singleImageView.center
            self.laterIconImageView.center.x = 270 + (self.laterIconImageView.frame.width/2)
            self.listIconImageView.center.x = 46 + (self.listIconImageView.frame.width/2)
            self.archiveIconImageView.center.x = 20 + (self.archiveIconImageView.center.x/2)
            self.deleteIconImageView.center.x = 272 + (self.deleteIconImageView.frame.width/2)
            
            // hide icons
            
            self.laterIconImageView.alpha = 0
            self.listIconImageView.alpha = 0
            self.archiveIconImageView.alpha = 0
            self.deleteIconImageView.alpha = 0

            
            
            
            self.backgroundView.backgroundColor = UIColor(red: CGFloat(220.0/255.0), green: CGFloat(220.0/255.0), blue: CGFloat(220.0/255.0), alpha: CGFloat(1.0))
        }
        
        // notice when panning is happening
        else if sender.state == UIGestureRecognizerState.Changed {
            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                // move to the left or right
                self.singleImageView.center.x = self.originalSingleImage.x + translation.x
                
                // icon stuff
                if (singleImageOriginX > -60 && singleImageOriginX <= 60){
                   
                    // make icons appear
                    self.laterIconImageView.alpha = 1
                    self.archiveIconImageView.alpha = 1
        
                }
                else {
                    // make icons trail single image
                    self.laterIconImageView.center.x = self.singleImageView.frame.width + translation.x + 20
                    self.archiveIconImageView.center.x = translation.x - 20

                    
                }
                
                }, completion: { (completed) -> Void in
                    //nothing
            })
            
            
            
        }
        
        // notice when panning is completed
        else if sender.state == UIGestureRecognizerState.Ended{
            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                self.singleImageView.center.x = self.originalSingleImage.x
                }, completion: { (completed) -> Void in
                    //nothing
            })
        }
        
        
        
    }

   

}
