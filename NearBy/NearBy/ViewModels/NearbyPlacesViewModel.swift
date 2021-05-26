//
//  NearbyPlacesViewModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import UIKit

class NearbyPlacesViewModel {
    
    // MARK:- Properties
    private var nearbyPlaces = [PlaceModel]()
    private var realTime:Bool = AppSettings.shared.isRealTimeMode()
    private let api:VenuesAPIProtocol = VenuesAPI()
    private var placesImages = [String:String]()
    
    private init(){}
    
    static var shared = NearbyPlacesViewModel()
    
    var placesCount:Int {
        return nearbyPlaces.count
    }
    
    
    func changeUpdateMode(realtime:Bool) {
        self.realTime = realtime
        AppSettings.shared.saveUpdateMode(realtime: realtime)
    }
    
    
    func getPlaces(lat:Double, long:Double, tableView:UITableView) {
        getPlacesAPI(lat: lat, long: long, tableView: tableView)
    }
    
    
    
    func place(forIndexPath indexPath:IndexPath) -> PlaceModel {
        return nearbyPlaces[indexPath.row]
    }
    
    private func formatImageLink(prefix:String,size:String ,suffix:String) -> String {
        return "\(prefix)\(size)x\(size)\(suffix)"
    }
    
    
}


//MARK:- APIs
extension NearbyPlacesViewModel {
    private func getPlacesAPI(lat:Double, long:Double, tableView:UITableView) {
        api.explore(lat: lat, long:long, view:tableView.superview ?? UIView()) { (result) in
            switch result {
            case .success(let resposnse):
                resposnse.response?.groups?.forEach({ group in
                    group.items?.forEach({ item in
                        self.nearbyPlaces.append(item.place ?? PlaceModel())
                    })
                })
                
                tableView.reloadData()
                
            case .failure(let error):
                /// GET from caching for `offline` mode
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
