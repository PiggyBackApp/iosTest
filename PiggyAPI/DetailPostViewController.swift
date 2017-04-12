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
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var emptySeats: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var creatorLink: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitle.text = detailDict["title"] as! String?
        destination.text = detailDict["destination"] as! String?
        origin.text = detailDict["origin"] as! String?
        status.text = detailDict["status"] as! String?
        capacity.text = "\(detailDict["passengerCapacity"]!)"
        emptySeats.text = "\(detailDict["emptySeats"]!)"
        textView.text = detailDict["description"] as! String?
        creatorLink.setTitle("\(detailDict["username"]!)", for: .normal)
        
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
//            pass = 22
        }
        else{
            driver = Int(keychain.get("userID")!)!
//            driver = 22
            pass = detailDict["creator"] as! Int
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
