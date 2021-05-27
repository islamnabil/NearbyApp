//
//  AppSettings.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import UIKit

class AppSettings {
    
    //MARK:-  Singleton
    private init(){}
    
    /// Access the singleton instance
    static var shared = AppSettings()
    
    
    // MARK:- Properties
    private enum status: String {
        case realTime = "Realtime"
        case singleUpdate = "Single Update"
     }
    
    // MARK:- Public Functions
    
    /// Get current realtime mode status & set the button's title with the status
    ///
    /// - Parameters:
    ///   - statusInfoFor: `UIBarButtonItem` to display current `Mode` (Default value for button = nil)
    func isRealTimeMode(statusInfoFor button:UIBarButtonItem? = nil) -> Bool {
        button?.title = modeName()
        return UserDefaults.standard.bool(forKey: "realTimeMode")
    }
    
    /// Update current `Mode` to be `Realtime` OR `Single Update`, set the button's title with the status, update `LocationController` with new mode.
    ///
    /// - Parameters:
    ///   - realtime: realtime mode to be `true` OR `false`
    ///   - statusInfoFor: `UIBarButtonItem` to display current `Mode` (Default value for button = nil)
    func updateMode(realtime:Bool, statusInfoFor button:UIBarButtonItem? = nil) {
        UserDefaults.standard.setValue(realtime, forKey:"realTimeMode")
        button?.title = modeName()
        LocationController.shared.requestLocation(realTime: realtime)
    }
    
    
    // MARK:- Private Functions
    private func modeName() -> String {
        return isRealTimeMode() ? status.realTime.rawValue : status.singleUpdate.rawValue 
    }
    
    
}
