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
    @IBOutlet weak var origin: UILabel!
    
    
    
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
        
//        postTitle.text = detailDict["title"] as! String?
        destination.text = detailDict["destination"] as! String?
        origin.text = detailDict["origin"] as! String?
//        status.text = detailDict["status"] as! String?
//        capacity.text = "\(detailDict["passengerCapacity"]!)"
//        emptySeats.text = "\(detailDict["emptySeats"]!)"
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
        
        if  "DR" == detailDict["postType"] as! String? {
            
            performSegue(withIdentifier: "requestPass", sender: self)
        }
        else{
            
            performSegue(withIdentifier: "requestDr", sender: self)
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
