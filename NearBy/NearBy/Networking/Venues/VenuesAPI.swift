//
//  VenuesAPI.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit

protocol VenuesAPIProtocol {
    func explore(lat:Double, long:Double,showLoading:Bool,completion: @escaping (Result<NearbyPlacesModel, NSError>) -> Void)
    func venuesPhotos(venueId:String,completion: @escaping (Result<VenuePhotosModel, NSError>) -> Void)

}

class VenuesAPI: BaseAPI<VenuesNetwrking>, VenuesAPIProtocol {
    func explore(lat: Double, long: Double, showLoading:Bool = false, completion: @escaping (Result<NearbyPlacesModel, NSError>) -> Void) {
        fetchData(target: .exlpore(lat: "\(lat)", long: "\(long)"), responseClass: NearbyPlacesModel.self, showLoading: showLoading) { (result) in
            completion(result)
        }
    }
    
    func venuesPhotos(venueId: String, completion: @escaping (Result<VenuePhotosModel, NSError>) -> Void) {
        fetchData(target: .venuesPhotos(venueId: venueId), responseClass: VenuePhotosModel.self) { (result) in
            completion(result)
        }
    }

}
