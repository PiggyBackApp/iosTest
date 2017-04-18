//
//  NumberPiggysRequestViewController.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 4/18/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class NumberPiggysRequestViewController: UIViewController {

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
