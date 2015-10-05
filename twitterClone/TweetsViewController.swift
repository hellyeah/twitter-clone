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
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "populateTimeline", forControlEvents: UIControlEvents.ValueChanged)
        
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tableView
        dummyTableVC.refreshControl = refreshControl


//        self.title = "Your Title"
//
//        var homeButton : UIBarButtonItem = UIBarButtonItem(title: "LeftButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
//
//        var logButton : UIBarButtonItem = UIBarButtonItem(title: "RightButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
//
//        self.navigationItem.leftBarButtonItem = homeButton
//        self.navigationItem.rightBarButtonItem = logButton
        populateTimeline()
        
        tableView.reloadData()
    }
    
    func populateTimeline () {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            if error != nil {
                print(error)
            } else {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
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
        //cell?.tweetLabel.text = self.tweets![indexPath.row].text
        cell!.tweet = self.tweets![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets == nil {
            return 0
        } else {
            return self.tweets!.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // do something here
        //segue and transfer data
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = self.tableView.indexPathForCell(sender as! TweetCell)
        if segue.identifier == "selectTweet" {
            let vc = segue.destinationViewController as? TweetViewController
            print(indexPath!.row)
            vc!.tweet = self.tweets![indexPath!.row]
            print(vc?.tweet)
        }
    }
}
