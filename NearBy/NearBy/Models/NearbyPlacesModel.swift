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
    var venue:VenueModel?
}

struct VenueModel:Codable {
    var id:String?
    var name:String?
    var location:VenueLocationModel?
}

struct VenueLocationModel:Codable {
    var formattedAddress:[String]?
}
