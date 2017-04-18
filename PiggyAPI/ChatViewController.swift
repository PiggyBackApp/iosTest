//
//  ChatViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/7/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
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
//        if ((requestModel?["accepted"]!) != nil) {
//            print("NOT RESPNSDED YET")
//        }
        // Do any additional setup after loading the view.
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
