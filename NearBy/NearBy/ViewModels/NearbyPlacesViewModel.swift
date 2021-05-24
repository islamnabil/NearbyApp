//
//  NearbyPlacesViewModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import Foundation

class NearbyPlacesViewModel {
    
    // MARK:- Properties
    private var nearbyPlaces = [PlaceModel]()
    private var realTime:Bool = AppSettings.shared.isRealTimeMode()
    
    private init(){}
    
    static var shared = NearbyPlacesViewModel()
    
    var placesCount:Int {
        return nearbyPlaces.count
    }
   
    
    func changeUpdateMode(realtime:Bool) {
        self.realTime = realtime
        AppSettings.shared.saveUpdateMode(realtime: realtime)
    }
    
    
    func getPlaces(lat:Double, long:Double) {
        
    }
    
    
    
    func place(forIndexPath indexPath:IndexPath) -> PlaceModel {
        return nearbyPlaces[indexPath.row]
    }
    
    func placeAddress(indexPath:IndexPath) -> String {
        return nearbyPlaces[indexPath.row].location?.address ?? "No address avaiable"
    }
    
    
    func getImageLink(indexPath:IndexPath) -> String {
        let placeId = nearbyPlaces[indexPath.row].id
        // call get venue's photos api, then format image link with response data
        
        return formatImageLink(prefix: "1", size: "250", suffix: "2")
    }
    
    private func formatImageLink(prefix:String,size:String ,suffix:String) -> String {
        return "\(prefix)\(size)x\(size)\(suffix)"
    }
    
    
    
//    private func getData(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
}
