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
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "edit-icon@3x.png"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(TweetsViewController.callMethod), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        

        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()

        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    func callMethod() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let composeVC = storyboard.instantiateViewController(withIdentifier: "ComposeViewController") as? ComposeViewController {
            self.navigationController?.pushViewController(composeVC, animated: true)
        }
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
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
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
    
    func profileImageViewTapped(cell: TableViewCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController {
            //profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
   
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navgivationController = segue.destination as! UINavigationController
        let vc = navgivationController.topViewController as! DetailViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[(indexPath?.row)!]
        vc.tweet = tweet
        
    }
    

}
