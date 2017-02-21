//
//  DetailPostViewController.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 2/20/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    var detailDict :[String:AnyObject]!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var userPosted: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var emptySeats: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitle.text = detailDict["title"] as! String?
        destination.text = detailDict["destination"] as! String?
        origin.text = detailDict["origin"] as! String?
        status.text = detailDict["status"] as! String?
        capacity.text = "\(detailDict["passengerCapacity"]!)"
        emptySeats.text = "\(detailDict["emptySeats"]!)"
        textView.text = detailDict["description"] as! String?
        
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
