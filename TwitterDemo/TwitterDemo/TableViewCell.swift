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
    
    var tweet: Tweet!{
        didSet{
            nameLabel.text = tweet.name
            thumbimageView.setImageWith(tweet.profileImageUrl!)
            screenLabel.text = tweet.screenName
            descriptionLabel.text = tweet.description
            timeLabel.text = tweet.timestamp as String
            
            
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

}
