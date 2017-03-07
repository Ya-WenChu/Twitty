//
//  TableViewCell.swift
//  TwitterDemo
//
//  Created by Yawen on 27/2/2017.
//  Copyright © 2017 Ya-Wen Chu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!{
        didSet{
            nameLabel.text = tweet.name!
            thumbimageView.setImageWith(tweet.profileImageUrl!)
            screenLabel.text = "@\(tweet.screenName!)"
            descriptionLabel.text = tweet.text!
            favCount.text = ("\(tweet.favoritesCount)")
            retweetCount.text = ("\(tweet.retweetCount)")
            
            let timeAgo = Int(Date().timeIntervalSince(tweet.timestamp!))
            let ago = convertSecondToDateAgo(seconds: timeAgo)
            timeLabel.text = ago
            
            
            if(tweet.retweeted! == true)
            {
                retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            }else{
                retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            }
            
            
            if(tweet.favorited! == true)
            {
                favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            }else{
                favButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            }
            
        }
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbimageView.layer.cornerRadius = 5;
        thumbimageView.clipsToBounds = true;
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func convertSecondToDateAgo(seconds: Int) -> String {
        var result: String?
        if(seconds/60 <= 59)
        {
            result = "\(seconds/60) m"
        }
        else if (seconds/3600 <= 23)
        {
            result = "\(seconds/3600) h"
        }
        else
        {
            result = "\(seconds/216000) d"
        }
        return result!
    }
    

}
