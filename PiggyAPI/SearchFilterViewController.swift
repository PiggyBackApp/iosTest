//
//  SearchFilterViewController.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 4/8/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchFilterViewController: UIViewController, UISearchBarDelegate, GMSAutocompleteFetcherDelegate {

    var searchResultController: SearchResultsController!
    var gmsFetcher: GMSAutocompleteFetcher!
    var originOrDestination = 0
    var resultsArray = [String]()
    var origin = ""
    var destination = ""
    
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinationButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchResultController = SearchResultsController()
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchWithAddressDestina(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        originOrDestination = 1
    }
    
    @IBAction func searchWithAddressOrigin(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        originOrDestination = 0
    }
    
    @IBAction func cancelSearchFilter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func filterPosts(_ sender: Any) {
        
    }
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
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
            originButton.setTitle(parsedCity, for: .normal)
            originButton.titleLabel?.adjustsFontSizeToFitWidth = true
            origin = parsedCity!
        }
            
        else if originOrDestination == 1 {
            destinationButton.setTitle(parsedCity, for: .normal)
            destination = parsedCity!
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

extension SearchFilterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func SearchFilterViewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
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
