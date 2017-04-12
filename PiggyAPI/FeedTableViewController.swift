//
//  FeedTableViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/6/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class FeedTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentCtrl: UISegmentedControl!

    var postsJson : [[String:AnyObject]] = [[:]]
    var driversList : [[String:AnyObject]] = [[:]]
    var passengersList : [[String:AnyObject]] = [[:]]
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    var keyExists = false
    var valueToPass:[String:AnyObject]?
    
    @IBAction func segmentValueChange(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 95;
        
        if keychain.get("djangoToken") == nil {
            keyExists = false
        }else{
            keyExists = true
            getPosts()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(keyExists == false){
            self.signOut(self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if keychain.get("djangoToken") == nil {
            keyExists = false
        }else{
            keyExists = true
            getPosts()
        }
    }
    
    func getPosts(){
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        
//        print("\nKEYCHAIN\n")
//        
//        print(keychain.get("djangoToken")!)
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(postsEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
                response in
//                debugPrint(response)
                //to get status code
                var authSucc = false
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                        authSucc = true
                    case 200:
                        authSucc = true
                        print("example success 200")
                    case 401:
                        self.signOut(self)
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if(authSucc){
                    if let result = response.result.value {
                        self.postsJson = result as! [[String: AnyObject]]
//                        print(self.postsJson)
                        self.tableView.reloadData()
                        //                    print(JSON)
                        
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
        
        if let passList = postsJson.filter({ "PA" == $0["postType"] as? String}) as [[String:AnyObject]]? {
            let sortedPasengersList = passList.sorted{ $0["travelDate"] as! String > $1["travelDate"] as! String}
            passengersList = sortedPasengersList.reversed()
        }

        if let drivsList = postsJson.filter({ $0["postType"] as? String == "DR"}) as [[String:AnyObject]]? {
            
            let sortedDriversList = drivsList.sorted{ $0["travelDate"] as! String > $1["travelDate"] as! String}
            driversList = sortedDriversList.reversed()
        }
        
        if segmentCtrl.selectedSegmentIndex == 0 {
            return passengersList.count
        }
        
        else if segmentCtrl.selectedSegmentIndex == 1 {
            return driversList.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! CustomeTableViewCell
        
        if segmentCtrl.selectedSegmentIndex == 0 {
            cell.origin.text = passengersList[indexPath.row]["origin"] as! String?
            cell.destination.text = passengersList[indexPath.row]["destination"] as! String?
            cell.spotAvailable.text = "\(passengersList[indexPath.row]["emptySeats"]!)"
            cell.carEmoji.text = "🚗"

        }
            
        else if segmentCtrl.selectedSegmentIndex == 1 {
            //cell.textLabel?.text = driversList[indexPath.row]["title"] as! String?        }
        
            cell.origin.text = driversList[indexPath.row]["origin"] as! String?
            cell.destination.text = driversList[indexPath.row]["destination"] as! String?
            cell.spotAvailable.text = "\(driversList[indexPath.row]["emptySeats"]!)"
            cell.carEmoji.text = "🚗"
        //cell.textLabel?.text = postsJson[indexPath.row]["title"] as! String?
        
        }
        
        return cell
    }
    
    func signOut(_ sender: Any) {
        keychain.clear()
        self.performSegue(withIdentifier: "signoutSegue", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        if segmentCtrl.selectedSegmentIndex == 0 {
            valueToPass = passengersList[indexPath.row]
        }
        else if segmentCtrl.selectedSegmentIndex == 1 {
            valueToPass = driversList[indexPath.row]
        }
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! DetailPostViewController
            
            // your new view controller should have property that will store passed value
            viewController.detailDict = valueToPass
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
