//
//  TweetsViewController.swift
//  twitterClone
//
//  Created by David Fontenot on 10/1/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self


//        self.title = "Your Title"
//
//        var homeButton : UIBarButtonItem = UIBarButtonItem(title: "LeftButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
//
//        var logButton : UIBarButtonItem = UIBarButtonItem(title: "RightButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
//
//        self.navigationItem.leftBarButtonItem = homeButton
//        self.navigationItem.rightBarButtonItem = logButton

        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    //TableView Setup
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as? TweetCell
        cell?.tweetLabel.text = self.tweets![indexPath.row].text
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets == nil {
            return 0
        } else {
            return self.tweets!.count
        }
    }
}
