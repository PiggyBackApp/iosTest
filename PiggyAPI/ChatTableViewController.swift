//
//  ChatTableViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/7/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class ChatTableViewController: UITableViewController {

    var requestsJson : [[String:AnyObject]] = [[:]]
    var valueToPass:[String:AnyObject]?
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain

    override func viewDidLoad() {
        self.title = "Requests"
        getRequests()
        super.viewDidLoad()
        tableView.rowHeight = 70
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRequests()
    }

    
    func getRequests(){
        let requestsEP = "http://localhost:8000/api/requests/"
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(requestsEP, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
                var authSucc = false
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("~example success")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("~example success 200")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    if let result = response.result.value {
                        self.requestsJson = result as! [[String: AnyObject]]
                        print(self.requestsJson)
                        self.tableView.reloadData()
                        //                    print(JSON)
                        
                    }
                }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestsJson.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! RequestsTableViewCell
        var f_origin = ""
        var f_destination = ""
        var f_driver_username = ""
        var f_pass_username = ""
        var f_username = ""
        var f_date = ""
        
        if let origin = requestsJson[indexPath.row]["origin"] as? String {
            f_origin = origin
        }
        
        if let destination = requestsJson[indexPath.row]["destination"] as? String {
            f_destination = destination
        }
        
        if let driver_username = self.requestsJson[indexPath.row]["driver_username"] as? String {
            f_driver_username = driver_username
        }
        
        if let passenger_username = self.requestsJson[indexPath.row]["passenger_username"] as? String {
            f_pass_username = passenger_username
        }
        
        if f_pass_username == "\(keychain.get("userID")!)" {
            f_username = f_driver_username
        }
        else{
            f_username = f_pass_username
        }
        
        if let travelDate = self.requestsJson[indexPath.row]["travelDate"] {
            f_date = travelDate as! String
            //SETTING DATE FORMAT:
            print("tiny rickkkkkk " + f_date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            let date = dateFormatter.date(from: f_date)
            print(date)
            dateFormatter.dateFormat = "MMM d, h:mm a"
            f_date = dateFormatter.string(from: date!)
            print(f_date)
        }
        
        
        cell.tripLocations.text = f_origin + " to " + f_destination
        cell.date.text = f_date
        cell.username.text = f_username
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")

        valueToPass = requestsJson[indexPath.row]
        valueToPass?["myUserID"] = keychain.get("userID") as AnyObject
        
        performSegue(withIdentifier: "chatCellToChat", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "chatCellToChat") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! ChatViewController
            
            // your new view controller should have property that will store passed value
            viewController.requestModel = valueToPass
        }
        
    }
    

}
