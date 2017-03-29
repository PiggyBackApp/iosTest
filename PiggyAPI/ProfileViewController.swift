//
//  ProfileViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/6/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var ranking: UILabel!
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    var profileModel : [String:AnyObject] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        

        
        
    }
    
    func getProfile(){
        
        let customUsersEndPoint = "http://localhost:8000/api/customUsers/\(keychain.get("userID")!)/"
        
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(customUsersEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
                //                debugPrint(response)
                //to get status code
                var authSucc = false
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("example success 200")
                    case 401:
                        self.signOutButton(self)
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    if let result = response.result.value {
                        self.profileModel = result as! [String: AnyObject]
                        print(self.profileModel)
                        let firstName = self.profileModel["user"]?["first_name"] as! String
                        let lastName = self.profileModel["user"]?["last_name"] as! String
//                        let rankNum = Float("\(self.profileModel["rating"]!)")
                        let rankNum = (self.profileModel["rating"] as!  NSString).floatValue
                        
                        self.profileName.text = firstName.capitalized + " " + lastName.capitalized
                        self.ranking.text = "\(rankNum)"
                    }
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        keychain.clear()
        performSegue(withIdentifier: "profileToLogin", sender: self)
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
