//
//  WriteReviewViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/7/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class WriteReviewViewController: UIViewController {
    
    var requestModel : [String:AnyObject]?
    var ratingChosen : Int = 0

    @IBOutlet weak var reviewText: UITextView!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    @IBAction func starPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            ratingChosen = 1
            star1.tintColor = UIColor.blue
            star2.tintColor = UIColor.gray
            star3.tintColor = UIColor.gray
            star4.tintColor = UIColor.gray
            star5.tintColor = UIColor.gray
        case 2:
            ratingChosen = 2
            star1.tintColor = UIColor.blue
            star2.tintColor = UIColor.blue
            star3.tintColor = UIColor.gray
            star4.tintColor = UIColor.gray
            star5.tintColor = UIColor.gray
        case 3:
            ratingChosen = 3
            star1.tintColor = UIColor.blue
            star2.tintColor = UIColor.blue
            star3.tintColor = UIColor.blue
            star4.tintColor = UIColor.gray
            star5.tintColor = UIColor.gray
        case 4:
            ratingChosen = 4
            star1.tintColor = UIColor.blue
            star2.tintColor = UIColor.blue
            star3.tintColor = UIColor.blue
            star4.tintColor = UIColor.blue
            star5.tintColor = UIColor.gray
        case 5:
            ratingChosen = 5
            star1.tintColor = UIColor.blue
            star2.tintColor = UIColor.blue
            star3.tintColor = UIColor.blue
            star4.tintColor = UIColor.blue
            star5.tintColor = UIColor.blue
        default:
            star1.tintColor = UIColor.gray
            star2.tintColor = UIColor.gray
            star3.tintColor = UIColor.gray
            star4.tintColor = UIColor.gray
            star5.tintColor = UIColor.gray
        }

    }
    
    @IBAction func submitReview(_ sender: Any) {
//        let reviewsEP = "http://localhost:8000/api/reviews/"
//        
        let reviewer : Int
        var reviewee : Int
        
        
        
        let passenger = requestModel!["passenger"]! as! Int32
        let driver = requestModel!["driver"]! as! Int32
        let myUserID = (requestModel?["myUserID"] as! NSString).intValue
        if passenger  == myUserID  {
            reviewer = Int(passenger)
            reviewee = Int(driver)
        }else{
            reviewer = Int(driver)
            reviewee = Int(passenger)
        }
        print(passenger)
        print(driver)
        print(myUserID)
        
        
        let reviewsEP = "http://localhost:8000/api/reviews/"

        
        
        let newReview = ["reviewee": reviewee,
                       "reviewer": reviewer,
                       "request": requestModel?["id"]!,
                       "rating": ratingChosen,
                       "comment": reviewText.text!] as [String : Any]

        
        Alamofire.request(reviewsEP, method: .post, parameters: newReview, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
            response in
                debugPrint(response)
                print(response)
                var authSucc = false
                if let status = response.response?.statusCode {
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
                    if response.result.value != nil {
                        //TODO: validate
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reviewText.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        reviewText.layer.borderWidth = 1.0
        reviewText.layer.cornerRadius = 5
        
        star1.tintColor = UIColor.gray
        star2.tintColor = UIColor.gray
        star3.tintColor = UIColor.gray
        star4.tintColor = UIColor.gray
        star5.tintColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelReview(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
