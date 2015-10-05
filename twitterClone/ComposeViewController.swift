//
//  ComposeViewController.swift
//  twitterClone
//
//  Created by David Fontenot on 10/5/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var tweetTextField: UITextField!
    @IBAction func tapTweet(sender: AnyObject) {
        //call tweet function with text in text field
        TwitterClient.sharedInstance.composeTweet(self.tweetTextField.text! as String, reply_id: nil) { (tweets, error) -> () in
            if error != nil {
                print(error)
            } else {
                print("tweet tweet")
            }
        }
        
    }
    
}
