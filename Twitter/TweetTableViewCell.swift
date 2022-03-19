//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Isabel Silva on 3/12/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    var favorited:Bool = false
    var tweetId = -1
    var retweeted:Bool = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)        }
    }
    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    func configure(with tweet: NSDictionary){
        tweetId = tweet["id"] as! Int
        setFavorite(tweet["favorited"] as! Bool)
        setRetweet(tweet["retweeted"] as! Bool)
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
    
    @IBAction func FavoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed:\(error)")
            })
            
        }else{
                TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                    self.setFavorite(false)
                }, failure: { (error) in
                    print("Un Favorite did not succeed:\(error)")
                })
        }
    }
    @IBAction func Retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (error) in
            print("Error is retweeting:\(error)")
        })
    }
    //    let toBeFavorited = !favorited


}
