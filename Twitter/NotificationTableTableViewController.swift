//
//  NotificationTableTableViewController.swift
//  Twitter
//
//  Created by Isabel Silva on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
// resource url https://api.twitter.com/1.1/statuses/home_timeline.json

class NotificationTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
    }
    
    @objc func loadTweet(){
        numberOfTweet = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweetRawData: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweetRawData{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { Error in print( "could not retreive tweet!!")
            
        })
        
    }
    
        func loadMoreTweets(){
            let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
            numberOfTweet = numberOfTweet + 10
            let myParams = ["count":numberOfTweet]
    
            TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweetRawData: [NSDictionary]) in
                self.tweetArray.removeAll()
                for tweet in tweetRawData{
                    self.tweetArray.append(tweet)
                }
                self.tableView.reloadData()
            }, failure: { Error in print("could not retreive tweet in LoadMoreTweets!!")
            })
        }
    
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row + 1 == tweetArray.count {
                loadMoreTweets()
            }
        }
    
    @IBAction func onLogout(_ sender: Any) {
    
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell",for: indexPath) as? TweetTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(with: tweetArray[indexPath.row])
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

   

 


}
