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
        }
    }
}
