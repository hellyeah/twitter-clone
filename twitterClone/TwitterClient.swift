//
//  TwitterClient.swift
//  twitterClone
//
//  Created by David Fontenot on 10/1/15.
//  Copyright © 2015 David Fontenot. All rights reserved.
//

import UIKit

let twitterConsumerKey = "Hsc86fWahIEU6u2uTNPAv7LcH"
let twitterConsumerSecret = "A4A9mkkniKyfyU4KPzbSWCeP8M1WzHn7GcPTKEpenKuUOi8JuE"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}
