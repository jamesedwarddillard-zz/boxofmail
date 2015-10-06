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
    var originalFeedImage: CGPoint!
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
            self.listIconImageView.center.x = 270 + (self.listIconImageView.frame.width/2)
            self.archiveIconImageView.center.x = 46 + (self.archiveIconImageView.frame.width/2)
            self.deleteIconImageView.center.x = 46 + (self.deleteIconImageView.frame.width/2)
            
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
        
                }
                else {
                    // make icons trail single image
                    self.laterIconImageView.center.x = self.singleImageView.frame.width + translation.x + 20
                    self.listIconImageView.center.x = self.singleImageView.frame.width + translation.x + 20
                    self.archiveIconImageView.center.x = translation.x - 20
                    self.deleteIconImageView.center.x = translation.x - 20

                    
                }
                
                if (singleImageOriginX <= -60 && singleImageOriginX > -260){
                    // yellow background and later icon
                    self.backgroundView.backgroundColor=UIColor(red: CGFloat(240.0/255.0), green: CGFloat(210.0/255.0), blue: CGFloat(70.0/255.0), alpha: CGFloat(1.0))
                    self.laterIconImageView.alpha = 1
                    self.listIconImageView.alpha = 0
                }
                else if singleImageOriginX <= -260 {
                    // brown background and list icon
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(215.0/255.0), green: CGFloat(166.0/255.0), blue: CGFloat(120.0/255.0), alpha: CGFloat(1.0))
                    self.laterIconImageView.alpha = 0
                    self.listIconImageView.alpha = 1
                }
                else if (singleImageOriginX >= 60 && singleImageOriginX < 260){
                    // green background and archive icon
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(116.0/255.0), green: CGFloat(215.0/255.0), blue: CGFloat(104.0/255.0), alpha: CGFloat(1.0))
                    self.archiveIconImageView.alpha = 1
                    self.deleteIconImageView.alpha = 0
                }
                else if (singleImageOriginX > 260){
                    // red background and delete icon
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(233.0/255.0), green: CGFloat(85.0/255.0), blue: CGFloat(59.0/255.0), alpha: CGFloat(1.0))
                    self.archiveIconImageView.alpha = 0
                    self.deleteIconImageView.alpha = 1
                    
                }
                
                }, completion: { (completed) -> Void in
                    //nothing
            })
            
        }
        
        // notice when panning is completed
        else if sender.state == UIGestureRecognizerState.Ended{
            var swipeBackEarly = singleImageOriginX > -60 && singleImageOriginX < 60
            var swipeBackLeft = singleImageOriginX >= 60 && velocity.x < 0
            var swipeBackRight = singleImageOriginX <= -60 && velocity.x > 0
            var singleMessageReset = swipeBackEarly || swipeBackLeft || swipeBackRight

            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                if singleMessageReset {
                    self.singleImageView.center.x = self.originalSingleImage.x
                }
                
                else if singleImageOriginX >= 60 && velocity.x > 0 { // swiped right
                    UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                        self.singleImageView.center = CGPoint(x: self.singleImageView.center.x + self.singleImageView.frame.width, y: self.originalSingleImage.y)
                        self.archiveIconImageView.alpha = 0
                        self.deleteIconImageView.alpha = 0
                        
                        }, completion: { (completed) -> Void in
                            self.hideMessage()
                    })
                    
                
                    
                }
                
                }, completion: { (completed) -> Void in
                    //nothing
            })
        }
        
        
        
    }
    func hideMessage(){
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.singleImageView.hidden = true
            self.backgroundView.center.y -= self.singleImageView.frame.height
            self.feedImageView.center.y -= self.singleImageView.frame.height
            }) { (completed) -> Void in
                //nothing
        }
        
    }

   

}
