//
//  AppSettings.swift
//  NearBy
//
//  Created by Islam Elgaafary on 24/05/2021.
//

import Foundation

class AppSettings {
    private init(){}
    
    static var shared = AppSettings()
    
    
    func isRealTimeMode() -> Bool {
        return UserDefaults.standard.bool(forKey: "realTimeMode")
    }
    
    func saveUpdateMode(realtime:Bool) {
        UserDefaults.standard.setValue(realtime, forKey:"realTimeMode")
    }
}
