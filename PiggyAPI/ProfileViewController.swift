//
//  ProfileViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/6/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain

    override func viewDidLoad() {
        super.viewDidLoad()

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
