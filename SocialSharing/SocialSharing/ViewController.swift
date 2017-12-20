//
//  ViewController.swift
//  SocialSharing
//
//  Created by Mimi Chenyao on 12/19/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit
import Social 

class ViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNoteTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNoteTextView() {
        
        // Constraints
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noteTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Styling rounded borders and a border line
        noteTextView.layer.cornerRadius = 9.0
        noteTextView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).cgColor
        noteTextView.layer.borderWidth = 1.2
    }
    
    @IBAction func showShareOptions(sender: AnyObject) {
        // Dismiss keyboard if visible
        if noteTextView.isFirstResponder {
            noteTextView.resignFirstResponder()
        }
        
        let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: .actionSheet)
        
        // Share on Twitter
        let tweetAction = UIAlertAction(title: "Share on Twitter", style: .default, handler: { (action) -> Void in
            
            // If sharing to Twitter is possible.
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                
                // Initialize default VC for sharing the post
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                // Set default post message
                twitterComposeVC?.setInitialText("#myMotiv")
                
                // Display compose VC
                self.present(twitterComposeVC!, animated: true, completion: nil)
            }
                
            // If sharing to Twitter is not possible
            else {
                
                let tweetAlertController = UIAlertController(title: "", message: "You are not logged in to your Twitter account", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                
                tweetAlertController.addAction(okAction)
                
                self.present(tweetAlertController, animated: true, completion: nil)
            }
        })
        
        // Share on Facebook
        let facebookPostAction = UIAlertAction(title: "Share on FB", style: .default, handler: { (action) -> Void in
            
            // If sharing to FB is possible.
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                
                // Initialize default VC for sharing the post
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookComposeVC?.setInitialText("#myMotiv")
                
                self.present(facebookComposeVC!, animated: true, completion: nil)
            }
            
            // If sharing to FB is not possible
            else {
                let facebookAlertController = UIAlertController(title: "", message: "You are not logged into Facebook", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                facebookAlertController.addAction(okAction)
                
                self.present(facebookAlertController, animated: true, completion: nil)
            }
        })
        
        // More ...
        let moreAction = UIAlertAction(title: "More", style: .default, handler: { (action) -> Void in })
        
        let dismissAction = UIAlertAction(title: "Close", style: .cancel, handler: { (action) -> Void in })
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

