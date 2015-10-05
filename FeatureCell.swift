//
//  FeatureCell.swift
//  twitterClone
//
//  Created by David Fontenot on 10/5/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class FeatureCell: UITableViewCell {
    
    @IBAction func tapRetweet(sender: AnyObject) {
        print(id_as_string2)
        TwitterClient.sharedInstance.retweet(id_as_string2!) { (response, error) -> () in
            if error != nil {
                print(error)
            } else {
                print(response)
                //self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func tapFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(id_as_string2!) { (response, error) -> () in
            if error != nil {
                print(error)
            } else {
                print(response)
                //self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func tapReply(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    var id_as_string2: String?
    
    var tweet: Tweet! {
        didSet {
            id_as_string2 = tweet.id_as_string!
        }
    }
}
