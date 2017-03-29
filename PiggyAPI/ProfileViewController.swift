//
//  ProfileViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/6/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var ranking: UILabel!
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstName = "Agustin"
        let lastName = "Stein"
        let rankNum = "3.5"
        
        profileName.text = firstName + " " + lastName
        ranking.text = rankNum
        
        // Do any additional setup after loading the view.
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
