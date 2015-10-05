//
//  ComposeViewController.swift
//  twitterClone
//
//  Created by David Fontenot on 10/5/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    var id: String? = nil
    @IBOutlet weak var tweetTextField: UITextField!
    @IBAction func tapTweet(sender: AnyObject) {
        //call tweet function with text in text field
        print(id)
        TwitterClient.sharedInstance.composeTweet(self.tweetTextField.text! as String, reply_id: self.id!) { (tweets, error) -> () in
            if error != nil {
                print(error)
            } else {
                print("tweet tweet")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    @IBAction func tapCancel(sender: AnyObject) {
                        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
