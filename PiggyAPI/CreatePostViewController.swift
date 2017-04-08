//
//  CreatePostViewController.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 2/20/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces

class CreatePostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate, GMSAutocompleteFetcherDelegate{

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var passengersField: UITextField!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    
    let keychain = LoginViewController(nibName: nil, bundle: nil).keychain
    
    var passsengerPickOptions = ["1", "2", "3", "4", "5", "6"]
    var typePickOptions = ["Driver", "Passenger"]
    var originOrDestination = 0
    
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    var dateAndTime = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchResultController = SearchResultsController()
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let typePickerView = UIPickerView()
        let passengerPickerView = UIPickerView()
        
        typePickerView.tag = 1
        passengerPickerView.tag = 2
        
        typePickerView.delegate = self
        passengerPickerView.delegate = self
        
        passengersField.inputView = passengerPickerView
        typeField.inputView = typePickerView
        
        
        descriptionField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionField.layer.borderWidth = 1.0
        descriptionField.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
//    MARK: UIPICKER DELEGATES:
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 { //type
            return typePickOptions.count
        }
        else if pickerView.tag == 2{
            return passsengerPickOptions.count
        }else{
            return typePickOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 { //type
            return typePickOptions[row]
        }
        else if pickerView.tag == 2{
            return passsengerPickOptions[row]
        }else{
            return typePickOptions[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 { //type
            typeField.text = typePickOptions[row]
        }
        else if pickerView.tag == 2{
            passengersField.text = passsengerPickOptions[row]
        }else{
            typeField.text = typePickOptions[row]
        }
    }

    
    @IBAction func chooseDate(_ sender: UIDatePicker) {
        
        //"2017-03-29T08:04:01.994677Z"
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000000'Z'" //"YYYY-MM-DDThh:mm[:ss[.uuuuuu]][+HH:MM|-HH:MM|Z]"
        dateAndTime = myFormatter.string(from: sender.date)
        
        print(dateAndTime)
    }
    
    
    @IBAction func searchWithAddressOrigin(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        originOrDestination = 0
        
    }
    
    
    @IBAction func searchWithAddressDestination(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        originOrDestination = 1
    }
    
    
    
    @IBAction func exitCreateView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createPost(_ sender: Any) {
        
//   TODO:     check if all things filled!
        var type: String
        if "Driver" == typeField.text {
            type = "DR"
        }else{
            type = "PA"
        }
        
        let postsEndPoint = "http://localhost:8000/api/posts/?format=json"
        let newPost = ["title": titleField.text!,
                    "creator": keychain.get("userID")!,
                    "description": descriptionField.text!,
                    "postType": type,
                    "origin": originLabel.text!,
                    "destination": destinationLabel.text!,
                    "emptySeats": Int(passengersField.text!)! ,
                    "passengerCapacity": Int(passengersField.text!)! ,
                    "travelDate": dateAndTime ,
                    "status": "A"] as [String : Any]
        
        
        Alamofire.request(postsEndPoint, method: .post, parameters: newPost, encoding: JSONEncoding.default, headers: nil)
            .responseJSON{
                response in
                debugPrint(response)
                print(response)
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
                    if response.result.value != nil {
                    //TODO: validate
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("-----------\n\n\n\n--------")

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
    
    
    
    
//    MARK: SEARCH STUFF:
    
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        let placeClient = GMSPlacesClient()
        //
        //
        //        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
        //           // NSError myerr = Error;
        //            print("Error @%",Error.self)
        //
        //            self.resultsArray.removeAll()
        //            if results == nil {
        //                return
        //            }
        //
        //            for result in results! {
        //                if let result = result as? GMSAutocompletePrediction {
        //                    self.resultsArray.append(result.attributedFullText.string)
        //                }
        //            }
        //
        //            self.searchResultController.reloadDataWithArray(self.resultsArray)
        //
        //        }
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }
    
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("\n\nPlace name: \(place.name)")
        print("\nPlace address: \(place.formattedAddress)")
        
        var address = place.formattedAddress
        
        let parts = address?.components(separatedBy: ",")
        var parsedCity = parts?[(parts?.count)!-3]
        
        if (parsedCity?[0] == " ") {

            parsedCity?.remove(at: (parsedCity?.startIndex)!)
        }
        
        print(parsedCity)
        
        if originOrDestination == 0 {
            originLabel.text = parsedCity
        }
        
        else if originOrDestination == 1 {
            destinationLabel.text = parsedCity
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
}

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}

extension CreatePostViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    
    
    func CreatePostViewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

