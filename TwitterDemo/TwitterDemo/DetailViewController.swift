//
//  DetailViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 5/3/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var descriptionLa: UILabel!
    @IBOutlet weak var numRetweet: UILabel!
    @IBOutlet weak var numFav: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var reButton: UIButton!
    
    var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userName.text = tweet!.name
        userImageView.setImageWith((tweet!.profileImageUrl)!)
        screenName.text = "@\(tweet!.screenName!)"
        descriptionLa.text = tweet!.text
        numRetweet.text = "\(tweet!.retweetCount)"
        numFav.text = "\(tweet!.favoritesCount)"
        time.text = "\(tweet!.timestamp!)"
        
        
        if(tweet?.retweeted! == true)
        {
            reButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        }else{
            reButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
        }
        
        
        if(tweet?.favorited! == true)
        {
            favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
        }
        
    }
    
    @IBAction func onFav(_ sender: Any) {
         favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
    }
    
    @IBAction func onRe(_ sender: Any) {
        reButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(_ sender: Any) {
        performSegue(withIdentifier: "ReplySegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navgivationController = segue.destination as! UINavigationController
        let vc = navgivationController.topViewController as! ReplyViewController
        vc.tweet=self.tweet
        
    }

    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
