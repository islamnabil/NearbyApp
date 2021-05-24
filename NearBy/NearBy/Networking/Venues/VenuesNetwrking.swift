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
}

extension VenuesNetwrking: TargetType {
    var baseURL: String {
        return "\(Domain.url)"
    }
    
    var path: String {
        switch self {
        case .exlpore:
            return "explore"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .exlpore:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .exlpore(let lat, let long):
            return .requestParameters(parameters: [
                "client_id":Domain.client_id,
                "secret_id": Domain.client_secret,
                "v":Domain.v,
                "lat":lat,
                "long":long
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
