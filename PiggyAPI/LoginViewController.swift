//
//  LoginViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/5/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        keychain.set("hello world", forKey: "my key")
//        keychain.get("my key")

//        passwordTextField.textContentType
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
        let loginEndPoint = "http://localhost:8000/authenticate/?format=json"
        let loginCreds = [
                    "username": usernameTextField.text!,
                    "password": passwordTextField.text!]
        
      
        
        
        Alamofire.request(loginEndPoint, method: .post, parameters: loginCreds, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    case 200:
                        print("example success 200")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    print(result)
                    let tokenDict = result as! [String: AnyObject]

                    // store token in KeyChain if authenticated
                    if let tokenStr = tokenDict["token"] as! String? {
                        self.keychain.set(tokenStr, forKey: "djangoToken")
                        print(tokenStr)
                        if let currentUserID = tokenDict["id"] as! Int? {
                            self.keychain.set("\(currentUserID)", forKey: "userID")
                            print(currentUserID)
                        }
                        self.performSegue(withIdentifier: "loginToFeed", sender: self)
                    }
                    
                    if let tokenStr = tokenDict["non_field_errors"] {
                        print(tokenStr)
                        //alert user!
                    }
                    
                }

        }
        
        
    }
    
    @IBAction func signupSequeAction(_ sender: Any) {
        performSegue(withIdentifier: "signupSegue", sender: self)
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
