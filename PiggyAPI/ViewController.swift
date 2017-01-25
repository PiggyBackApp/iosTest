//
//  ViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 1/24/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        newPost()
//        getPosts()
//        getPost()
//        getUsers()
        newUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func newPost(){
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        
        let newPost = ["title": "AGUSTIN",
                       "creator": "http://localhost:8000/api/customUsers/3/",
                       "description": "AGUSTIN",
                       "postType": "DR",
                       "origin": "AGUSTIN",
                       "destination": "AGUSTIN",
                       "emptySeats": 1,
                       "passengerCapacity": 2,
                       "status": "A"] as [String : Any]
        
        
        Alamofire.request(postsEndPoint, method: .post, parameters: newPost, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
        }
    }
    
    func getPosts(){
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        
        
        Alamofire.request(postsEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
        }
    }
    
    
    func getPost(){
//        TODO: request specific post with parameters
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        
        Alamofire.request(postsEndPoint, method: .get, parameters: ["id": "1"], encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
        }
    }
    
    
    
    func getUsers(){
        let usersEndPoint = "http://localhost:8000/api/customUsers/?format=json"
        
        
        Alamofire.request(usersEndPoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
        }
    }
    
    func newUser(){
        let usersEndPoint = "http://localhost:8000/api/customUsers/?format=json"
        let user = ["first_name": "Charlie",
                    "last_name": "Strong",
                    "email": "strong@ufl.edu",
                    "username": "alamo",
                    "password": "firefirefire"]
        
        let newCustomUser = ["user": user,
                             "rating": "3.11",
                             "school": "alamo",
                             "car": "fire",
                             "phoneNumber": "19542979"] as [String : Any]
        
        
        Alamofire.request(usersEndPoint, method: .post, parameters: newCustomUser, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
        }
    }

    
    
    

}

