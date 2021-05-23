//
//  Constants.swift
//
//  Created by Islam Elgaafary on 23/05/2021.
//

import Foundation

struct ErrorMessage {
    static let genericError = "Something went wrong !!"
}

struct Domain {
    static let url = "https://api.foursquare.com/v2/venues/"
    static let client_id = "D0T2FACC5A3RTLSFMUNPUD0TQAUIWUXAJMHV4HHSYKYB4LMT"
    static let client_secret = "NNFEM4D15V2NZHD2WRNIUM032VHDMD3DPSXKGG4FWFX2RDRX"
    static let v = "20120609"
}

struct ErrorMsg:Codable {
    var error:String
}
