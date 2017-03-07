//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Yawen on 27/2/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var name:String?
    var screenName: String?
    var profileImageUrl: URL?
    var text: String?
    var timestamp: Date?
    var id: Int?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var retweeted: Bool?
    var favorited: Bool?
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        name = dictionary.value(forKeyPath: "user.name") as! String?
        
        let user = dictionary["user"] as! NSDictionary
        
        let imgURL = user["profile_image_url_https"] as? String
        profileImageUrl = URL(string: imgURL!)
        
        
        
        screenName = dictionary.value(forKeyPath: "user.screen_name")
         as! String?
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        id = dictionary["id"] as? Int
        
        self.retweeted = dictionary["retweeted"] as? Bool
        self.favorited = dictionary["favorited"] as? Bool
        
        
        let timestampString = dictionary["created_at"] as? String
        

        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString as String )! as Date
            

            
        }
        
        

        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
        
    }

}
