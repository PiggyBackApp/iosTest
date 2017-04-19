//
//  DetailPostViewController.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 2/20/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class DetailPostViewController: UIViewController {
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    
    var detailDict :[String:AnyObject]!
    

    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var origin: UILabel!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var creatorLink: UIButton!
    
    @IBOutlet weak var piggy1: UIImageView!
    @IBOutlet weak var piggy2: UIImageView!
    @IBOutlet weak var piggy3: UIImageView!
    @IBOutlet weak var piggy4: UIImageView!
    @IBOutlet weak var piggy5: UIImageView!
    @IBOutlet weak var piggy6: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(detailDict["creator"] as? Int != Int(keychain.get("userID")!)!){
            deleteButton.isHidden = true
            editButton.isHidden = true
        }
        
        else{
            requestButton.isHidden = true
        }
        
        let dateFormatter = DateFormatter()
        let myDate = detailDict["travelDate"]
        let postCreatedDate = detailDict["timePosted"]
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: myDate as! String)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        let postedTime = dateFormatter.date(from: postCreatedDate as! String)
        
        dateFormatter.dateFormat = "MMM d, h:mm a"
        let dateString = dateFormatter.string(from: date!)
        
        let dateFormatter1 = DateFormatter()
        print(dateFormatter1.timeSince(from: NSDate(), numericDates: true))  // Just now
        
        let timeAgo = dateFormatter1.timeSince(from: postedTime! as NSDate, numericDates: true)
        print(timeAgo)  // 9 minutes ago
        
        createdDate.text = "\(timeAgo)"
        dateLabel.text = "\(dateString)"
        destination.text = detailDict["destination"] as! String?
        origin.text = detailDict["origin"] as! String?
        textView.text = detailDict["description"] as! String?
        creatorLink.setTitle("\(detailDict["username"]!)", for: .normal)
        
        switch ( (detailDict["seats_taken"] as! Int)) {
        case 0:
            piggy1.image = UIImage.init(named: "piggy-empty-1")
            piggy2.image = UIImage.init(named: "piggy-empty-1")
            piggy3.image = UIImage.init(named: "piggy-empty-1")
            piggy4.image = UIImage.init(named: "piggy-empty-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 1:
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-empty-1")
            piggy3.image = UIImage.init(named: "piggy-empty-1")
            piggy4.image = UIImage.init(named: "piggy-empty-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 2:
            
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-empty-1")
            piggy4.image = UIImage.init(named: "piggy-empty-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 3:
            
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-head-1")
            piggy4.image = UIImage.init(named: "piggy-empty-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 4:
            
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-head-1")
            piggy4.image = UIImage.init(named: "piggy-head-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 5:
            
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-head-1")
            piggy4.image = UIImage.init(named: "piggy-head-1")
            piggy5.image = UIImage.init(named: "piggy-head-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        case 6:
            
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-head-1")
            piggy4.image = UIImage.init(named: "piggy-head-1")
            piggy5.image = UIImage.init(named: "piggy-head-1")
            piggy6.image = UIImage.init(named: "piggy-head-1")
        default:
            piggy1.image = UIImage.init(named: "piggy-head-1")
            piggy2.image = UIImage.init(named: "piggy-head-1")
            piggy3.image = UIImage.init(named: "piggy-empty-1")
            piggy4.image = UIImage.init(named: "piggy-empty-1")
            piggy5.image = UIImage.init(named: "piggy-empty-1")
            piggy6.image = UIImage.init(named: "piggy-empty-1")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func usernameTapped(_ sender: Any) {
        
    }
    @IBAction func makeRequest(_ sender: Any) {
        let requestEP = "http://localhost:8000/api/requests/?format=json"
        
        
        var driver  : Int
        var pass    : Int
        
        if  "DR" == detailDict["postType"] as! String? {
            driver = detailDict["creator"] as! Int
            pass = Int(keychain.get("userID")!)!
            performSegue(withIdentifier: "requestPass", sender: self)

            
//            pass = 22
        }
        else{
            driver = Int(keychain.get("userID")!)!
//            driver = 22
            pass = detailDict["creator"] as! Int
            performSegue(withIdentifier: "requestDr", sender: self)
        }
        
        
        
        
        let newRequest = ["driver": driver,
                          "passenger": pass,
                          "post": detailDict["id"]!] as [String : Any]
        
        Alamofire.request(requestEP, method: .post, parameters: newRequest, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
//                debugPrint(response)
//                print(response)
                var httpCode = 0
                var authSucc = false
                if let status = response.response?.statusCode {
                    httpCode = status
                    switch(status){
                    case 201:
                        print("example success")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("example success 200")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    let alert = UIAlertController(title: "Request Sent!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Request Failed!", message: "Error code: \(httpCode)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
        
    }
    
    @IBAction func deletePost(_ sender: Any) {
        
        
        let postsEndPoint = "http://localhost:8000/api/posts/\(detailDict["id"]!)/?format=json"
        

        Alamofire.request(postsEndPoint, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
                print(response)
                var authSucc = false
                if let status = response.response?.statusCode {
                    switch(status){
                    case 204:
                        print("example success")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("example success 200")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    _ = self.navigationController?.popViewController(animated: true)
                }
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! EditPostViewController
            
            // your new view controller should have property that will store passed value
            viewController.detailDict = detailDict
        }
        if (segue.identifier == "otherUserProfiles") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! OtherUserProfileViewController
            
            // your new view controller should have property that will store passed value
            viewController.userID = detailDict["creator"] as? Int
        }
        if (segue.identifier == "requestPass") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! NumberPiggysRequestViewController
            
            // your new view controller should have property that will store passed value
            viewController.detailDict = detailDict
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



extension DateFormatter {
    /**
     Formats a date as the time since that date (e.g., “Last week, yesterday, etc.”).
     
     - Parameter from: The date to process.
     - Parameter numericDates: Determines if we should return a numeric variant, e.g. "1 month ago" vs. "Last month".
     
     - Returns: A string with formatted `date`.
     */
    func timeSince(from: NSDate, numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        if components.year! >= 2 {
            result = "\(components.year!) years ago"
        } else if components.year! >= 1 {
            if numericDates {
                result = "1 year ago"
            } else {
                result = "Last year"
            }
        } else if components.month! >= 2 {
            result = "\(components.month!) months ago"
        } else if components.month! >= 1 {
            if numericDates {
                result = "1 month ago"
            } else {
                result = "Last month"
            }
        } else if components.weekOfYear! >= 2 {
            result = "\(components.weekOfYear!) weeks ago"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                result = "1 week ago"
            } else {
                result = "Last week"
            }
        } else if components.day! >= 2 {
            result = "\(components.day!) days ago"
        } else if components.day! >= 1 {
            if numericDates {
                result = "1 day ago"
            } else {
                result = "Yesterday"
            }
        } else if components.hour! >= 2 {
            result = "\(components.hour!) hours ago"
        } else if components.hour! >= 1 {
            if numericDates {
                result = "1 hour ago"
            } else {
                result = "An hour ago"
            }
        } else if components.minute! >= 2 {
            result = "\(components.minute!) minutes ago"
        } else if components.minute! >= 1 {
            if numericDates {
                result = "1 minute ago"
            } else {
                result = "A minute ago"
            }
        } else if components.second! >= 3 {
            result = "\(components.second!) seconds ago"
        } else {
            result = "Just now"
        }
        
        return result
    }
}
