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
    
    var detailDict :[String:AnyObject]!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var emptySeats: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var creatorUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitle.text = detailDict["title"] as! String?
        destination.text = detailDict["destination"] as! String?
        origin.text = detailDict["origin"] as! String?
        status.text = detailDict["status"] as! String?
        capacity.text = "\(detailDict["passengerCapacity"]!)"
        emptySeats.text = "\(detailDict["emptySeats"]!)"
        textView.text = detailDict["description"] as! String?
        creatorUsername.text = "\(detailDict["username"]!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
