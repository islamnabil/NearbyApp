//
//  NearbyPlacesViewModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit
import CoreLocation

class NearbyPlacesViewModel {
    
    // MARK:- Properties
    private var nearbyPlaces = [PlaceModel]()
    private var placesImages = [String:String]()
    private let api:VenuesAPIProtocol = VenuesAPI()
    private var showLoading = true
    
    var placesCount:Int {
        return nearbyPlaces.count
    }
    
    // MARK:- Singleton
    private init(){}
    static var shared = NearbyPlacesViewModel()
    
    
    // MARK:- Public functions
    func setupLocation(forViewCotroller vc:UIViewController & CLLocationManagerDelegate, statusInfoFor button:UIBarButtonItem? = nil)  {
        LocationController.shared.setupLocation(viewController: vc, realtime: AppSettings.shared.isRealTimeMode(statusInfoFor: button))
    }
    
    func changeUpdateMode(realtime:Bool, statusInfoFor button:UIBarButtonItem? = nil) {
        AppSettings.shared.updateMode(realtime: realtime,statusInfoFor: button)
    }
    
    
    func getPlaces(lat:Double, long:Double, tableView:UITableView) {
        nearbyPlaces.removeAll()
        getPlacesAPI(lat: lat, long: long, tableView: tableView)
    }
    
    
    func place(forIndexPath indexPath:IndexPath) -> PlaceModel {
        return nearbyPlaces[indexPath.row]
    }
    
    
    // MARK:- Private functions
    private func formatImageLink(prefix:String,size:String ,suffix:String) -> String {
        return "\(prefix)\(size)x\(size)\(suffix)"
    }
    
    
}


//MARK:- APIs
extension NearbyPlacesViewModel {
    private func getPlacesAPI(lat:Double, long:Double, tableView:UITableView) {
        api.explore(lat: lat, long:long, showLoading: showLoading) { (result) in
            self.showLoading = false
            
            switch result {
            case .success(let resposnse):
                
                resposnse.response?.groups?.forEach({ group in
                    group.items?.forEach({ item in
                        self.nearbyPlaces.append(item.place ?? PlaceModel())
                    })
                })
                
                if self.nearbyPlaces.count == 0 {
                    ErrorView(errorType: .NoDataFound, onView: tableView)
                }else {
                    tableView.reloadData()
                }
                
            case .failure(let error):
                /// GET from caching for `offline` mode
                ErrorView(errorType: .SomeError, onView: tableView)
                print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
            
        }
    }
    
    
    
    func getPlacePhoto(id:String, index:Int, table:UITableView){
        var imageLink = String()
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
                        self.nearbyPlaces[index].image = "imageLink"
                        self.placesImages[id] = "imagelink"
                        table.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }
        }
    }
    
}
