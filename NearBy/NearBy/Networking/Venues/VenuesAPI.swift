//
//  VenuesAPI.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit

protocol VenuesAPIProtocol {
    func explore(lat:Double, long:Double,view:UIView,completion: @escaping (Result<NearbyPlacesModel, NSError>) -> Void)
}

class VenuesAPI: BaseAPI<VenuesNetwrking>, VenuesAPIProtocol {
    func explore(lat: Double, long: Double, view: UIView, completion: @escaping (Result<NearbyPlacesModel, NSError>) -> Void) {
        fetchData(target: .exlpore(lat: "\(lat)", long: "\(long)"), responseClass: NearbyPlacesModel.self, view: view) { (result) in
            completion(result)
        }
    }
    
    
}
