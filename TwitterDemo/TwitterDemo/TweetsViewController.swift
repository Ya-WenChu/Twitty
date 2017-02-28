//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Yawen on 27/2/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        

        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            /*for tweet in tweets{
                print(tweet.text!)
            }*/
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.tweet = tweets[indexPath.row]
        
        
        return cell
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }else{
            return 0
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        var indexPath = tableView.indexPath(for: (sender as! UIButton).superview?.superview as! UITableViewCell)
        let tweet = tweets[(indexPath?.row)!]
        TwitterClient.sharedInstance?.retweet(id: tweet.id!)
        let cell = (sender as! UIButton).superview?.superview as! TableViewCell
        sleep(UInt32(1))
        
        TwitterClient.sharedInstance?.homeTimeLine(
        success:
            {(tweets: [Tweet]) in
                self.tweets = tweets
                self.tableView.reloadData()
                 },
        failure:
            {( error: Error) in
                print("Error: \(error.localizedDescription)")
        })
        cell.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        tweet.retweeted = true;
        tableView.reloadData()
    }
    
    @IBAction func favv(_ sender: Any) {
        var indexPath = tableView.indexPath(for: (sender as! UIButton).superview?.superview as! UITableViewCell)
        let tweet = tweets[(indexPath?.row)!]
        TwitterClient.sharedInstance?.favorite(id: tweet.id!)
        sleep(UInt32(1))
        
        TwitterClient.sharedInstance?.homeTimeLine(
        success:
            {(tweets: [Tweet]) in
                self.tweets = tweets
                self.tableView.reloadData()
        },
        failure:
            {( error: Error) in
                print("Error: \(error.localizedDescription)")
        })
        tweet.favorited = true
        self.tableView.reloadData()
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
