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
    
    var origin : String?
    var destination : String?
    
    
    @IBAction func segmentValueChange(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 115;
        
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
        if let org = self.origin{
            print("ORG: \(org)")
        }
        if let des = self.destination{
            print("DES: \(des)")
        }
        
        if keychain.get("djangoToken") == nil {
            keyExists = false
        }else{
            keyExists = true
            getPosts()
        }
    }
    
    func removeSpaces(originDestination : String) -> String{
        let underlinedString = originDestination.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print(underlinedString)
        return underlinedString
    }
    
    
    func getPosts(){
        print("~~~~~~~~~~~~~~~~~~")
        print("ORIGIN: \(String(describing: self.origin))")
        print("DEST: \(String(describing: self.destination))")
        print("~~~~~~~~~~~~~~~~~~")
        let headers = [
            "Authorization": "Token \(keychain.get("djangoToken")!)",
            "Content-Type": "application/json"
        ]
        
                if (origin == nil) && (destination == nil){
                    let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
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
                                    //  print(self.postsJson)
                                    self.tableView.reloadData()
                                    //  print(JSON)
                                    
                                }
                            }
                    }
                }
                else if (origin == nil){
                    let underlineDestination = removeSpaces(originDestination: self.destination!)
                    let postsEndPoint = "http://localhost:8000/api/posts/destination/q=\(underlineDestination)/?format=json"
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
                                    //  print(self.postsJson)
                                    self.tableView.reloadData()
                                    //  print(JSON)
                                    
                                }
                            }
                    }
                }
                else if (destination == nil){
                    let underlineOrigin = removeSpaces(originDestination: self.origin!)
                    let postsEndPoint = "http://localhost:8000/api/posts/origin/q=\(underlineOrigin)/?format=json"
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
                                    //  print(self.postsJson)
                                    self.tableView.reloadData()
                                    //  print(JSON)
                                    
                                }
                            }
                    }
                }
                else{
                    let underlineDestination = removeSpaces(originDestination: self.destination!)
                    let underlineOrigin = removeSpaces(originDestination: self.origin!)

                    let postsEndPoint = "http://localhost:8000/api/posts/both/q=\(underlineOrigin)/q=\(underlineDestination)/?format=json"
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
                                    //  print(self.postsJson)
                                    self.tableView.reloadData()
                                    //  print(JSON)
                                    
                                }
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
        let dateFormatter = DateFormatter()

        if segmentCtrl.selectedSegmentIndex == 0 {
            cell.origin.text = passengersList[indexPath.row]["origin"] as! String?
            cell.destination.text = passengersList[indexPath.row]["destination"] as! String?
            
            cell.user.text = "\(passengersList[indexPath.row]["username"]!)"
            
            let myDate = passengersList[indexPath.row]["travelDate"] as! String?
            //print(myDate)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            let date = dateFormatter.date(from: myDate!)
            
            dateFormatter.dateFormat = "MMM d, h:mm a"
            
            let dateString = dateFormatter.string(from: date!)
            let dateAndTime = dateFormatter.date(from: (passengersList[indexPath.row]["travelDate"]!) as! String)
            
            cell.date.text = "\(dateString)"

            //cell.date.text = "\(passengersList[indexPath.row]["travelDate"]!)"

        }
            
        else if segmentCtrl.selectedSegmentIndex == 1 {
            //cell.textLabel?.text = driversList[indexPath.row]["title"] as! String?        }
        
            cell.origin.text = driversList[indexPath.row]["origin"] as! String?
            cell.destination.text = driversList[indexPath.row]["destination"] as! String?
            cell.user.text = "\(driversList[indexPath.row]["username"]!)"
            
            let myDate = driversList[indexPath.row]["travelDate"] as! String?
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            let date = dateFormatter.date(from: myDate!)
            
            dateFormatter.dateFormat = "MMM d, h:mm a"
            
            let dateString = dateFormatter.string(from: date!)
            
            let dateAndTime = dateFormatter.date(from: (driversList[indexPath.row]["travelDate"]!) as! String)
            
            //print("--------------", dateString as! String?)
            
            cell.date.text = "\(dateString)"
            
//            cell.date.text = "\(driversList[indexPath.row]["travelDate"]!)"
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
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SearchFilterViewController {
            self.origin = sourceViewController.origin
            self.destination = sourceViewController.destination
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! DetailPostViewController
            
            // your new view controller should have property that will store passed value
            viewController.detailDict = valueToPass
        }
        if (segue.identifier == "popoverFilter") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! SearchFilterViewController
            
            // your new view controller should have property that will store passed value
            if let origin = self.origin {
                viewController.origin = origin
            }
            if let destination = self.destination {
                viewController.destination = destination
            }
        }
    }
 
    @IBAction func modalToFilter(_ sender: UIBarButtonItem) {
//        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilterViewController") as! SearchFilterViewController
//        let filterVC = self.storyboard.
//        filterVC.delegateRes = self
        performSegue(withIdentifier: "popoverFilter", sender: self)
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
    
    
////    MARK: - FILTER PROTOCOL
//    
//    func setOriginAndDestination(origin: String, destination: String) {
//        print("WE IN THIS BIIIIIIIII \(origin) \(destination)")
//        self.origin = origin
//        self.destination = destination
//    }

}
