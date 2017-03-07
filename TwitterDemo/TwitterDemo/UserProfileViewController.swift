//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 6/3/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = user!.name! as String?
        profileImage.setImageWith(user!.picUrl!)
        screenName.text = "@\(user!.screenname!)"
        numTweets.text = String(user!.tweetCount!)
        numFollowers.text = String(user!.followerCount!)
        numFollowing.text = String(user!.followeringCount!)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
