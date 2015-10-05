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
    
    //takes dictionary of tweets as params for pagination to check against
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func retweet (id: String, completion: (response: String?, error: NSError?) -> ()) {
        //https://api.twitter.com/1.1/statuses/retweet/:id.json
        //parameters: {id: "\(id)"}
        //let params: NSDictionary? = ["id": id!]
        //let idString = id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        //print(idString)
        //let urlString = "1.1/statuses/retweet/" + idString + ".json"
        //print(urlString)
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //completion(response: (((response as! [NSDictionary])[0]["id_str"]) as? String), error: nil)
            completion(response: "blah", error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error retweeting tweet \(id)")
                completion(response: nil, error: error)
        })
    }
    
    func favorite (id: String, completion: (response: String?, error: NSError?) -> ()) {
        //https://api.twitter.com/1.1/statuses/retweet/:id.json
        //parameters: {id: "\(id)"}
        let params: NSDictionary? = ["id": id]
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //completion(response: ((response as! [NSDictionary])[0]["id_str"]) as? String, error: nil)
            completion(response: "blah", error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error favoriting tweet \(id)")
                completion(response: nil, error: error)
        })
    }
//
//    //takes dictionary of tweets as params for pagination to check against
//    func composeTweet(status: String?, reply_id: String?, completion: (error: NSError?) -> ()) {
//        POST("1.1/statuses/l", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            
//            completion(, error: nil)
//            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                print("error composing tweet")
//                completion(tweets: nil, error: error)
//        })
//    }
//    
//    //same as compose tweet but inlcludes in_reply_to_status_id variable
//    func composeReply() {
//        
//    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion

        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
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
                //should persist user as current user
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
        }) { (error:NSError!) -> Void in
            print("failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }

    }

}
