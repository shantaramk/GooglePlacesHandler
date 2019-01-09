//
//  GooglePlacesHandler.swift
//
//  Created by Shantaram Kokate on 1/3/19.
//

import UIKit
import GooglePlaces
import GoogleMaps

class GooglePlacesHandler: NSObject {
    
    // MARK: - Internal Properties
    
    static let shared = GooglePlacesHandler()
    internal let kPlacesAPIKey = "kGOOGLEMAPKEY"
    internal let kMapsAPIKey = "kGOOGLEMAPKEY"
    
    // MARK: - Internal Methods
    
    func provideAPIKey() {
        GMSServices.provideAPIKey(kMapsAPIKey)
        GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
    }
    
    func placeAutocompleteQuery(_ query: String, callback:@escaping (GMSAutocompletePredictionsCallback)) {
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(query, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            callback(results, error)
        })
    }
    
    func placeMetaInfo(_ placeId: String, callback: @escaping (GMSPlaceResultCallback)) {
        let placeID = placeId
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            callback(place, error)
        })
    }
    
    func googleMapsiOSSDKReverseGeocoding(from locationCoordinate: CLLocationCoordinate2D, callback:@escaping (GMSReverseGeocodeCallback)) {
        let aGMSGeocoder: GMSGeocoder = GMSGeocoder()
        aGMSGeocoder.reverseGeocodeCoordinate(CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)) { (gmsReverseGeocodeResponse, error) in
            callback(gmsReverseGeocodeResponse, error)
        }
    
    }
}
