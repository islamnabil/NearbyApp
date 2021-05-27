//
//  BaseAPI.swift
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import Foundation
import Alamofire
import SDWebImage
import PKHUD

class BaseAPI<T: TargetType> {
    
    // MARK:- Fetch Data
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, showLoading:Bool = false, completion:@escaping (Swift.Result<M,NSError>) -> Void) {
        
        if showLoading {
            HUD.show(.progress)
        }
       
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)!
        let headers = Alamofire.HTTPHeaders(dictionaryLiteral: ("Accept", target.headers!["Accept"]!))
        let params = buildParams(task: target.task)
       

        
        Alamofire.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                HUD.hide()
                completion(.failure(error))
                return
            }
            
            if statusCode == 200 { // 200 reflect success response
                // Successful request
                
                /// Get the Json Response
                guard let jsonResponse = response.result.value else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.hide()
                    completion(.failure(error))
                    return
                }
                
                /// Get the Json Response data
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.hide()
                    completion(.failure(error))
                    return
                }
                
                /// Decode Json response data
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    HUD.hide()
                    completion(.failure(error))
                    return
                }
                
                HUD.hide()
                completion(.success(responseObj))
            }
            
            else {
                // ADD custom error base on status code 404 / 401 /
                // Error Parsing for the error message from the BE
                do {
                    let er = try JSONDecoder().decode(ErrorMsg.self, from: response.data!)
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: er.error])
                    HUD.hide()
                    completion(.failure(error))
                }catch {
                    HUD.hide()
                }
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
            }
        }
    }
    
    // MARK:- Build Parameters
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    
}


// MARK:- UIImageView extension
/// to get the image data from URL link with `SDWebImage` pod.
extension UIImageView {
    
    public func SetImage(link:String) {
        self.backgroundColor = #colorLiteral(red: 0.8115878807, green: 0.8115878807, blue: 0.8115878807, alpha: 1)
        if let url = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            self.sd_setImage(with: URL(string: url), completed: nil)
        }
    }
}
