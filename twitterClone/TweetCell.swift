//
//  TweetCell.swift
//  twitterClone
//
//  Created by David Fontenot on 10/1/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true

        //tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
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
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet.user?["name"] as? String
            //timestampLabel.text = tweet.createdAt
            profileImageView.setImageWithURL(NSURL(string:tweet.user?["profile_image_url"] as! String))
        }
    }

    func showTweet(tweet: Tweet) {


    }
}
