//
//  Tweet.swift
//  
//
//  Created by David Fontenot on 10/1/15.
//
//

import UIKit

class Tweet: NSObject {
    var user: [String:AnyObject]?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        //user = User(dictionary: dictionary["user"] as! NSDictionary)
        user = dictionary["user"] as? [String:AnyObject]
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
