//
//  NearbyPlacesViewModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit
import CoreLocation

class NearbyPlacesViewModel {
    
    //MARK:-  Singleton
    private init(){}
    
    /// Access the singleton instance
    static var shared = NearbyPlacesViewModel()
    
    
    // MARK:- Properties
    
    /// Places to be displayed in tableView
    private var nearbyPlaces = [PlaceModel]()
    
    /// Cach for places's images `[place_id:imageLink]`
    private var placesImages = [String:String]()
    
    /// Access VenuesAPI
    private let api:VenuesAPIProtocol = VenuesAPI()
    
    /// NeatbyPlaces's count
    var placesCount:Int {
        return nearbyPlaces.count
    }
    
    /// Show loading indicator (to show for first request ONLY)
    private var showLoading = true

    
    // MARK:- Public functions
    
    /// Setup location services with `LocationController` and get current `Mode` from `AppSettings`
    ///
    /// - Parameters:
    ///   - forViewCotroller: `UIViewController` that confirms `CLLocationManagerDelegate`
    ///   - statusInfoFor: `UIBarButtonItem` to display current `Mode` (Default value for button = nil)
    func setupLocation(forViewCotroller vc:UIViewController & CLLocationManagerDelegate, statusInfoFor button:UIBarButtonItem? = nil)  {
        LocationController.shared.setupLocation(viewController: vc, realtime: AppSettings.shared.isRealTimeMode(statusInfoFor: button))
    }
    
    
    /// Update current `Mode` to be `Realtime` OR `Single Update` with `AppSettings`
    ///
    /// - Parameters:
    ///   - realtime: realtime mode to be `true` OR `false`
    ///   - statusInfoFor: `UIBarButtonItem` to display current `Mode` (Default value for button = nil)
    func updateMode(realtime:Bool, statusInfoFor button:UIBarButtonItem? = nil) {
        AppSettings.shared.updateMode(realtime: realtime,statusInfoFor: button)
    }
    
    
    /// Get nearby places of current location by calling `getPlacesAPI`
    ///
    /// - Parameters:
    ///   - lat: Latitude of cuurent location
    ///   - long: longitude of cuurent location
    ///   - tableView: UITableView to display places
    func getPlaces(lat:Double, long:Double, tableView:UITableView) {
        nearbyPlaces.removeAll()
        getPlacesAPI(lat: lat, long: long, tableView: tableView)
    }
    
    
    /// Get specific place' data
    ///
    /// - Parameters:
    ///   - indexPath: index of place in `nearbyPlaces` array
    /// - Returns:
    ///    - place item of `nearbyPlaces`
    func place(forIndexPath indexPath:IndexPath) -> PlaceModel {
        return nearbyPlaces[indexPath.row]
    }
    
    
    // MARK:- Private functions
    
    /// Format the place's image link to call HTTP image request
    ///
    /// - Parameters:
    ///   - prefix: prefix of the image link
    ///   - size: size of the image (size x size)
    ///   - suffix: suffix of the image link
    /// - Returns:
    ///    - Formatted place's image link
    private func formatImageLink(prefix:String,size:String ,suffix:String) -> String {
        return "\(prefix)\(size)x\(size)\(suffix)"
    }
    
    
    
}



extension NearbyPlacesViewModel {
    
    //MARK:- Get Places API
    
    /// Get places API (Explore EndPoint)
    ///
    /// - Parameters:
    ///   - lat: Latitude of cuurent location
    ///   - long: longitude of cuurent location
    ///   - tableView: UITableView to display places
    private func getPlacesAPI(lat:Double, long:Double, tableView:UITableView) {
        api.explore(lat: lat, long:long, showLoading: showLoading) { (result) in
            
            /// make `showLoading` to false after first HTTP request
            self.showLoading = false
            
            switch result {
            case .success(let resposnse):
                
                /// Fetching places
                resposnse.response?.groups?.forEach({ group in
                    group.items?.forEach({ item in
                        self.nearbyPlaces.append(item.place ?? PlaceModel())
                    })
                })
                
                /// if NO places, then show an ErrorView `NoDataFound`
                if self.nearbyPlaces.count == 0 {
                    ErrorView(errorType: .NoDataFound, onView: tableView)
                }else {
                    tableView.reloadData()
                }
                
            case .failure(let error):
                /// if error response, then show an ErrorView `SomeError`
                ErrorView(errorType: .SomeError, onView: tableView)
                print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }

        }
        
    }
    
    
    //MARK:- Get Place Photo API
    
    /// Get place's photo API (venuesPhotos EndPoint),
    /// Called in `cellForRowAt` at Home's tableView to get the photo of current tableView row only
    ///
    /// - Parameters:
    ///   - id: place id
    ///   - index: index of current place
    ///   - tableView: UITableView displaying places
    func getPlacePhoto(id:String, index:Int, table:UITableView){
        var imageLink = String()
        
        /// if imageLink of current place (tableView's row) in images cashing `placesImages`, then return
        /// Else : get imageLink of the place with `formatImageLink`, save the current imageLink with its place's id in `placesImages` for cashing, add imageLink in `nearbyPlaces` current place with the index, Reload current tableView row only.
        if placesImages[id] != nil {
            return
        }else {
            DispatchQueue.global(qos: .background).async {
                self.api.venuesPhotos(venueId: id) { (result) in
                    switch result {
                    
                    case .success(let resposnse):
                        let item = resposnse.response?.photos?.items?.first
                        imageLink = self.formatImageLink(prefix: item?.prefix ?? "", size: "500", suffix: item?.suffix ?? "")
                        self.placesImages[id] = imageLink
                        self.nearbyPlaces[index].image = imageLink
                        table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                        
                    case .failure(let error):
                        print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
                        /// NOTE: `VenuesPhotos` endPoint is a `premium` calls, so it has a daily limits.
                        /// Source: https://developer.foursquare.com/docs/places-api/rate-limits
                        ///
                        /// Exceeding limits API will return a`429 error` until the time of reset
                        /// so in this case I assume the returned imageLink data is `"imageLink"` instead of real link.
                        self.nearbyPlaces[index].image = "imageLink"
                        self.placesImages[id] = "imagelink"
                        table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }
        }
    }
    
    
}
