//
//  VenuesNetwrking.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import Foundation
import Alamofire

enum VenuesNetwrking {
    case exlpore(lat:String, long:String)
    case venuesPhotos(venueId:String)
}

extension VenuesNetwrking: TargetType {
    var baseURL: String {
        return "\(Domain.url)"
    }
    
    var path: String {
        switch self {
        case .exlpore:
            return "explore"
        case .venuesPhotos(let venueId):
            return "\(venueId)/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .exlpore, .venuesPhotos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .exlpore(let lat, let long):
            return .requestParameters(parameters: [
                "client_id":Domain.client_id,
                "client_secret": Domain.client_secret,
                "v":Domain.v,
                "ll":"\(lat),\(long)"
            ], encoding: URLEncoding.default)
            
        case .venuesPhotos:
            return .requestParameters(parameters: [
                "client_id":Domain.client_id,
                "client_secret": Domain.client_secret,
                "v":Domain.v,
                "group":"venue"
            ], encoding: URLEncoding.default)
        
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
            "Accept":"application/json"
            ]
        }
    }
    
    
}
