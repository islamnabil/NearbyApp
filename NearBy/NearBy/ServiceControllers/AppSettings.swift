//
//  AppSettings.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit

class AppSettings {
    private init(){}
    
    static var shared = AppSettings()
    
    func isRealTimeMode(statusInfoFor button:UIBarButtonItem? = nil) -> Bool {
        button?.title = modeName()
        return UserDefaults.standard.bool(forKey: "realTimeMode")
    }
    
    func updateMode(realtime:Bool, statusInfoFor button:UIBarButtonItem? = nil) {
        UserDefaults.standard.setValue(realtime, forKey:"realTimeMode")
        button?.title = modeName()
        LocationController.shared.requestLocation(realTime: realtime)
    }
    
    
    private func modeName() -> String {
        return isRealTimeMode() ? status.realTime.rawValue : status.singleUpdate.rawValue 
    }
    
    enum status: String {
        case realTime = "Realtime"
        case singleUpdate = "Single Update"
     }
    
}
