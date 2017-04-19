//
//  OwnRequestsTableViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/19/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift


class OwnRequestsTableViewController: UITableViewController {
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    
    var postsJson : [[String:AnyObject]] = [[:]]
    var detailDict :[String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose related post..."
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //         self.navigationItem.rightBarButtonItem = self.
        
        getOwnPosts()
    }
    
    func getOwnPosts(){
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        let postsEndPoint = "http://localhost:8000/api/selfposts/"
        Alamofire.request(postsEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
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
                    if let result = response.result.value {
                        self.postsJson = result as! [[String: AnyObject]]
                        //  print(self.postsJson)
                        self.tableView.reloadData()
                        //  print(JSON)
                        
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsJson.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCellSelf", for: indexPath)
        
        // Configure the cell...
        let origin = self.postsJson[indexPath.row]["origin"] as? String ?? ""
        let dest = self.postsJson[indexPath.row]["destination"] as? String ?? ""
        print(origin)
        print(dest)
        cell.textLabel?.text = origin + " to " + dest
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        makeRequest(driverPostID: self.postsJson[indexPath.row]["id"] as! Int)
//        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    
    
    func makeRequest(driverPostID: Int){
        let requestEP = "http://localhost:8000/api/requests/?format=json"
        
        var driver  : Int
        var pass    : Int
        
        pass = detailDict["creator"] as! Int
        driver = Int(keychain.get("userID")!)!
        
        
        let newRequest = ["driver": driver,
                          "passenger": pass,
                          "passengers" : detailDict["passengerCapacity"] as! Int,
                          "requester" : driver,
                          "post": driverPostID] as [String : Any]
        print(newRequest)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
