//
//  CreatePostViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/20/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class CreatePostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitCreateView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createPost(_ sender: Any) {
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        let newPost = ["title": "New Titleeee TEST",
                    "creator": "http://localhost:8000/api/customUsers/13/",
                    "description": "ios desc asdfasdfs asdfsad fsdaf sadf a",
                    "postType": "DR",
                    "origin": "ios",
                    "destination": "ios",
                    "emptySeats": 3,
                    "passengerCapacity": 3,
                    "status": "A"] as [String : Any]
        
        
        Alamofire.request(postsEndPoint, method: .post, parameters: newPost, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
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
                    if let result = response.result.value {
                    
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }
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
