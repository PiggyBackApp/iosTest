//
//  ChatViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/7/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import KeychainSwift
import Alamofire

class ChatViewController: UIViewController {
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    
    var requestModel : [String:AnyObject]?
    
    @IBOutlet weak var writeReviewButton: UIButton!
    @IBOutlet weak var confirmationLabel: UILabel!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let formattedToday = dateFormatter.string(from: today)
        let travelDateTime = requestModel!["travelDate"]!
        
        print(formattedToday)
        print(travelDateTime)
        
        if(travelDateTime as! String >= formattedToday){
            writeReviewButton.isHidden = true
        }
        
        if ((requestModel?["accepted"] as? NSNull) == NSNull()) {
            print("\(requestModel?["requester"]) and \(keychain.get("userID")!)")
            if requestModel?["requester"] as? Int == Int(keychain.get("userID")!) {
                print("requester should be me")
                confirmationLabel.text = "Awaiting reponse..."
                confirmationLabel.isHidden = false
                declineButton.isHidden = true
                acceptButton.isHidden = true
            }
            else{
                print("requester should NOT be me")
                confirmationLabel.text = ""
                confirmationLabel.isHidden = true
                declineButton.isHidden = false
                acceptButton.isHidden = false
            }
            
        }
        else if ((requestModel?["accepted"] as? Bool) == true) {
            confirmationLabel.text = "Trip confirmed!"
            confirmationLabel.isHidden = false
            declineButton.isHidden = true
            acceptButton.isHidden = true
            
        }
        else{
            print("trip declined")
            confirmationLabel.text = "Request declined..."
            confirmationLabel.isHidden = false
        }
    }

    @IBAction func acceptPressed(_ sender: Any) {
        createConfirmationRequest()
        changeRequestTo(accepted: true)
    }
    @IBAction func declinePressed(_ sender: Any) {
        changeRequestTo(accepted: false)
    }
    
    
    func createConfirmationRequest(){
        
        let conReqEP = "http://localhost:8000/api/confirmed_requests/?format=json"
        let newConReq = [   "post": requestModel?["post"] as! Int ,
                            "request": requestModel?["id"] as! Int,
                            "passengers": requestModel?["passengers"] as! Int
                       ] as [String : Any]
        
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(conReqEP, method: .post, parameters: newConReq, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
//                debugPrint(response)
//                print(response)
                var authSucc = false
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success newConReq!!!")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("example success 200 newConReq!!!")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    if response.result.value != nil {
                        //TODO: validate
                        
                    }
                    
                }
        }
    }
    
    func changeRequestTo(accepted: Bool){
        let reqID = requestModel?["id"] as! Int
        let requestEP = "http://localhost:8000/api/requests/\(reqID)/"
        requestModel?["accepted"] = accepted as AnyObject
        print(requestModel!)
        
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(requestEP, method: .put, parameters: requestModel!, encoding: JSONEncoding.default, headers: headers)
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
                    print("PUT success")
                    // TODO: pop to root view controller to get updated version
                }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func writeReviewSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "writeReviewSeg", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "writeReviewSeg") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! WriteReviewViewController
            
            // your new view controller should have property that will store passed value
            viewController.requestModel = requestModel!
        }
    }
    

}
