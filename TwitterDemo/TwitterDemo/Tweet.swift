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
    
    var idStr: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var retweeted: Bool?
    var favorited: Bool?
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        name = dictionary.value(forKeyPath: "user.name") as! String?
        
        let imageURLString = dictionary["user.profile_image_url_https"] as? String
        if imageURLString != nil{
            profileImageUrl = URL(string: imageURLString!)!
        }else{
            profileImageUrl = nil
        }
        //profileImageUrl = dictionary.value(forKeyPath: "user.profile_image_url_https") as! String?
        
        screenName = dictionary.value(forKeyPath: "user.screen_name")
         as! String?
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        idStr = dictionary["id_str"] as? String
        
        
        
        
        let timestampString = dictionary["created_at"] as? String
        

        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString as String )! as Date
            
            //timestamp = formatter.string(from: times?)
            
            
        }
        
        
        user = User.init(dictionary: dictionary.value(forKey: "user") as! NSDictionary)
        
        
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
