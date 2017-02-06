//
//  LoginViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/5/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        passwordTextField.textContentType
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginUser(_ sender: Any) {
        let loginEndPoint = "http://localhost:8000/api-token-auth/?format=json"
        let loginCreds = [
                    "username": usernameTextField.text!,
                    "password": passwordTextField.text!]
        
      
        
        
        Alamofire.request(loginEndPoint, method: .post, parameters: loginCreds, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
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
