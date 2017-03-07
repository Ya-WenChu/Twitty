//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 6/3/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userName.text = User.currentUser!.name! as String?
        screenName.text = "@\(User.currentUser!.screenname!)"
        profileImage.setImageWith((User.currentUser!.picUrl!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        if(!((tweetTextView.text?.isEmpty)!))
        {
            TwitterClient.sharedInstance?.reply(id: "", text: tweetTextView.text!, success: { (response: Tweet) in
                self.dismiss(animated: true, completion: nil)
            }, faliure: { (error: Error) in
                let errorAlertController = UIAlertController(title: "Error!", message: "Already replied to this Tweet", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
            })
        }
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
