//
//  NearbyPlacesModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import Foundation

struct NearbyPlacesModel:Codable {
    var response:NearbyPlacesResponse?
}

struct NearbyPlacesResponse:Codable {
    var groups:[NearbyPlacesGroup]?
}

struct NearbyPlacesGroup:Codable {
    var items:[NearbyPlacesItem]?
}

struct NearbyPlacesItem:Codable {
    var place:PlaceModel?
    
    enum CodingKeys: String, CodingKey {
        case place = "venue"
    }
}

struct PlaceModel:Codable {
    var id:String?
    var name:String?
    var image:String?
    var location:PlaceLocationModel?
}

struct PlaceLocationModel:Codable {
    var address:String?
}
