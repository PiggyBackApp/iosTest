//
//  SignupViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/5/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func signupNewUser(_ sender: Any) {
        let usersEndPoint = "http://localhost:8000/api/customUsers/?format=json"
        let user = ["first_name": firstNameTextField.text!,
                    "last_name": lastNameTextField.text!,
                    "email": emailTextField.text!,
                    "username": usernameTextField.text!,
                    "password": passwordTextField.text!]
        
        let newCustomUser = ["user": user,
                             "rating": "0",
                             "school": emailTextField.text!,
                             "car": "none",
                             "phoneNumber": "19542979"] as [String : Any]
        
        
        Alamofire.request(usersEndPoint, method: .post, parameters: newCustomUser, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
                print(response)
//                TODO: GET TOKEN BACK AFTER ACCOUNT IS CREATED!
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
                        self.segueToFeed()
                        print(result)
//                        let userDict = result as! [String: AnyObject]
//                        
//                        // store token in KeyChain if authenticated
//                        if let tokenStr = userDict["token_key"] {
//                            self.keychain.set(tokenStr as! String, forKey: "djangoToken")
//                            print(tokenStr)
//                            self.segueToFeed()
//                        }
//                        
//                        if let tokenStr = userDict["non_field_errors"] {
//                            print(tokenStr)
//                            //alert user!
//                        }
                        
                    }
                }
            }
    }
    
    func segueToFeed(){
        performSegue(withIdentifier: "feedSegue", sender: self)

    }
    
    
    
    
//    @IBAction func signupUser(_ sender: Any) {
    
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
