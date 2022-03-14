//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Isabel Silva on 3/12/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
   
    func configure(with tweet: NSDictionary){
        
        
        let user = tweet["user"] as! NSDictionary
        userNameLabel.text = user["name"] as? String
        tweetContentLabel.text = tweet["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            profileImageView.image = UIImage(data: imageData)
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
