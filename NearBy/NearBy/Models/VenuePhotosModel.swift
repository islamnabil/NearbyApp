//
//  VenuePhotosModel.swift
//  NearBy
//
//  Created by Islam Elgaafary on 26/05/2021.
//

import Foundation

struct VenuePhotosModel:Codable {
    var response:VenuePhotosResponse?
}

struct VenuePhotosResponse:Codable {
    var photos:VenuePhotosData?
}

struct VenuePhotosData:Codable {
    var items:[VenuePhotoItem]?
}

struct VenuePhotoItem:Codable {
    var id: String?
    var prefix: String?
    var suffix: String?
}
