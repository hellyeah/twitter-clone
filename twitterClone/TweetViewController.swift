//
//  TweetViewController.swift
//  twitterClone
//
//  Created by David Fontenot on 10/3/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tweetName = tweet.user?["name"] as? String
        print("tweet: \(tweetName)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
