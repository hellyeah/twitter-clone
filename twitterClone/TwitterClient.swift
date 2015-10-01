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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion

        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }, failure: { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        })

    }

    func openURL(url: NSURL) {

        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("received access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)

            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //print("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })

            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //print("home timeline: \(response)")
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    print("text: \(tweet.text). created \(tweet.createdAt)")
                }
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    //
                    print("error getting home timeline")
            })

            }) { (error:NSError!) -> Void in
                print("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }

    }

}
