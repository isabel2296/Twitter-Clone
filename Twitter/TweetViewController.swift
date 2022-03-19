//
//  TweetViewController.swift
//  Twitter
//
//  Created by Isabel Silva on 3/16/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
class TweetViewController: UIViewController {
    @IBOutlet weak var TweetTextView: UITextView!
    
//    let tweetUrl = "https://api.twitter.com/1.1/statuses/update.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        TweetTextView.becomeFirstResponder()
//        self.Twe = RSKPlaceholderTextView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 100))
//        self.view.addSubview(self.textView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelTweet(_ sender: Any) {
        dismiss(animated: true,
        completion: nil)
    }
    
    @IBAction func Tweet(_ sender: Any) {
        if (!TweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: TweetTextView.text, success: {
                self.dismiss(animated: true,completion: nil)
            }, failure: { (error) in
                print("Error in posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })}
          else{
                self.dismiss(animated: true,completion: nil)}
    }
    
//    @objc(textView:shouldChangeTextInRange:replacementText:) func textView (_ textView:UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
//        let characterLimit = 250
//        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
//        return newText.count < characterLimit
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
