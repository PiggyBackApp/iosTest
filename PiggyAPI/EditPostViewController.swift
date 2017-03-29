//
//  EditPostViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 3/3/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class EditPostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var passengerField: UITextField!
    
    var passsengerPickOptions = ["1", "2", "3", "4", "5", "6"]
    var typePickOptions = ["Driver", "Passenger"]
    
    var detailDict : [String:AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Filling in values to edit:
        
        titleField.text = detailDict["title"] as! String?
        descriptionField.text = detailDict["description"] as! String?
        if detailDict["postType"] as! String? == "DR" {
            typeField.text = "Driver"
        }
        else {
            typeField.text = "Passanger"
        }
        destinationField.text = detailDict["destination"] as! String?
        originField.text = detailDict["origin"] as! String?
        passengerField.text = "\(detailDict["passengerCapacity"]!)"
        
        
        
        
        
        // MARK: DELEGATE PREP:
        
        let typePickerView = UIPickerView()
        let passengerPickerView = UIPickerView()
        
        typePickerView.tag = 1
        passengerPickerView.tag = 2
        
        typePickerView.delegate = self
        passengerPickerView.delegate = self
        
        passengerField.inputView = passengerPickerView
        typeField.inputView = typePickerView
        
        
        descriptionField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionField.layer.borderWidth = 1.0
        descriptionField.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 { //type
            return typePickOptions.count
        }
        else if pickerView.tag == 2{
            return passsengerPickOptions.count
        }else{
            return typePickOptions.count
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 { //type
            return typePickOptions[row]
        }
        else if pickerView.tag == 2{
            return passsengerPickOptions[row]
        }else{
            return typePickOptions[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 { //type
            typeField.text = typePickOptions[row]
        }
        else if pickerView.tag == 2{
            passengerField.text = passsengerPickOptions[row]
        }else{
            typeField.text = typePickOptions[row]
        }
    }

    
    
    
    @IBAction func dismissEditVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func submitEdit(_ sender: Any) {
        print(detailDict["id"]!)
//        TODO:
//        to submit the edit, we need to have the post id ready
        
        
        var type: String
        if "Driver" == typeField.text {
            type = "DR"
        }else{
            type = "PA"
        }
        
        let postsEndPoint = "http://localhost:8000/api/posts/\(detailDict["id"]!)/?format=json"
        let updatedPost = ["title": titleField.text!,
                       "creator": "http://localhost:8000/api/customUsers/13/",
                       "description": descriptionField.text!,
                       "postType": type,
                       "origin": originField.text!,
                       "destination": destinationField.text!,
                       "emptySeats": Int(passengerField.text!)! ,
                       "passengerCapacity": Int(passengerField.text!)! ,
                       "status": "A"] as [String : Any]
        
        
        Alamofire.request(postsEndPoint, method: .put, parameters: updatedPost, encoding: JSONEncoding.default, headers: nil)
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
                    self.dismiss(animated: true, completion: nil)
                    // TODO: pop to root view controller to get updated version
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
