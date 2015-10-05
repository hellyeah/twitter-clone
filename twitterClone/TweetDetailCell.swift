//
//  TweetDetailCell.swift
//  twitterClone
//
//  Created by David Fontenot on 10/3/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {
    
    @IBOutlet weak var tweetDetailLabel: UILabel!
    @IBOutlet weak var profileImageDetailView: UIImageView!
    @IBOutlet weak var usernameDetailLabel: UILabel!
    @IBOutlet weak var timestampDetailLabel: UILabel!
    var id_as_string2: String?

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
    
    var tweet: Tweet! {
        didSet {
            tweetDetailLabel.text = tweet.text
            usernameDetailLabel.text = tweet.user?["name"] as? String
            timestampDetailLabel.text = tweet.createdAtShortString
            profileImageDetailView.setImageWithURL(NSURL(string:tweet.user?["profile_image_url"] as! String))
            id_as_string2 = tweet.id_as_string!
        }
    }
}
