//
//  NumberPiggysRequestViewController.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 4/18/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire


class NumberPiggysRequestViewController: UIViewController {

    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    var detailDict :[String:AnyObject]!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBAction func piggyChooser(_ sender: UIStepper) {
        
        if(sender.value == 1) {
            stepperLabel.text = "🐷"
        }
        
        else if(sender.value == 2){
            stepperLabel.text = "🐷🐷"

        }
        
        else if(sender.value == 3){
            stepperLabel.text = "🐷🐷🐷"

        }
        
        else if(sender.value == 4){
            stepperLabel.text = "🐷🐷🐷🐷"

        }
        
        else {
            stepperLabel.text = "🐷🐷🐷🐷🐷"

        }
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        
        let requestEP = "http://localhost:8000/api/requests/?format=json"
        
        var driver  : Int
        var pass    : Int
        
        driver = detailDict["creator"] as! Int
        pass = Int(keychain.get("userID")!)!
        
        
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
    @IBAction func cancelRequesu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
