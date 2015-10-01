//
//  User.swift
//  
//
//  Created by David Fontenot on 10/1/15.
//
//

import UIKit

var _currentUser: User?
var currentUserKey = "kCurrentUserKey"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }

    //automatically pull current user from persistence (NSUserDefaults)
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if (data != nil) {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    } catch {
                        //error
                    }

                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            //persist currentUser
            if _currentUser != nil {
                //try to store it
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    //error
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
