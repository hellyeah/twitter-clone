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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}
