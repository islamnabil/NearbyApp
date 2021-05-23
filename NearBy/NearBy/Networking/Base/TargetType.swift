//
//  TargetType.swift
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import Foundation
import Alamofire
import PKHUD

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

