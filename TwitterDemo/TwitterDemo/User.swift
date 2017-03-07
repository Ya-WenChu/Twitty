//
//  User.swift
//  TwitterDemo
//
//  Created by Yawen on 27/2/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class User: NSObject {
        static let userDidLogoutNotification = "UserDidLogout"
    var name: NSString?
    var screenname: NSString?
    var picUrl: URL?
    var profileUrl: String?
    var tagline: NSString?
    var tweetCount: Int?
    var followerCount: Int?
    var followeringCount: Int?
    var id: Int?
    
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary=dictionary
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        tweetCount = dictionary["statuses_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        followeringCount = dictionary["friends_count"] as? Int
        
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        /*if let profileUrlString = porfileUrlString{
            profileUrl = URL(string: profileUrlString)
            
        }*/
        if let profileUrlString = profileUrlString {
            picUrl = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? NSString
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User?
    {
        get{
            if (_currentUser == nil)
            {
            let defaults = UserDefaults.standard
            
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData
            {
                if let dic = try? JSONSerialization.jsonObject(with: userData, options:[])
                {
                    let dictionary = dic as! NSDictionary
                _currentUser = User(dictionary: dictionary )
                }
            }
            }
            return _currentUser
        
    }
        
        set(user){
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    

}
