//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 6/3/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetNum: UILabel!
    @IBOutlet weak var followingNum: UILabel!
    @IBOutlet weak var foollowersNum: UILabel!
    @IBOutlet weak var screenNameLa: UILabel!
    
    
    //var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = User.currentUser!.name! as String?
        userPic.setImageWith((User.currentUser!.picUrl!))
        tweetNum.text = "\(User.currentUser!.tweetCount!)"
        foollowersNum.text = "\(User.currentUser!.followerCount!)"
        followingNum.text = "\(User.currentUser!.followeringCount!)"
        screenNameLa.text = "@\(User.currentUser!.screenname!)"
        
        
        
        
        //print(User.currentUser?.name)

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
