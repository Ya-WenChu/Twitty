//
//  ReplyViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 6/3/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNa: UILabel!
    @IBOutlet weak var screenNa: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNa.text = tweet?.name
        screenNa.text = "@\(tweet!.screenName!)"
        profilePic.setImageWith((tweet!.profileImageUrl)!)
        replyTextView.text = "@\(tweet!.screenName!) "
        replyTextView.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func onTweet(_ sender: Any) {
        if(!((replyTextView.text?.isEmpty)!))
        {
         TwitterClient.sharedInstance?.reply(id: "\(tweet?.id)", text: replyTextView.text!, success: { (response: Tweet) in
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
